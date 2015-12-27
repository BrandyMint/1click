require 'upsert/active_record_upsert'

class EventCreator
  include Singleton

  def self.create!(user_agent:, query_string:)
    new(user_agent: user_agent, query_string: query_string).create!
  end

  def initialize(user_agent:, query_string:)
    @user_agent   = user_agent
    @query_string = query_string
    @time         = Time.now
  end

  def create!
    find_or_create_app
    log_app_event
    log_typed_event
  end

  private

  attr_reader :time, :query_string, :user_agent

  # {
  # "a"=>["333"],
  # "u"=>["3135142167941140"],
  # "v"=>["3960386852"],
  # "s"=>["1672143682"],
  # "m"=>["web"],
  # "t0"=>["eeee"],
  # "k0"=>["a", "1", "b", "2", "c", "3"],
  # "tm"=>["1449041172387"]
  # }
  #
  def query
    @query ||= CGI.parse query_string
  end

  def params
    @params ||= query.each_with_object({}) { |h,a| a[h.first]=h.second.first }
  end

  def log_typed_event
    if params['t'].present?
      create_visit_events!
    else
      entities = buildEntities
      entities.map do |e|
        create_page_event! e
      end
    end
  end

  def log_app_event
    AppEvent.create!(
      app_id:     params['a'],
      query:      query_string,
      user_agent: user_agent
    )
  end

  def find_or_create_app
    app
  end

  def app
    @app ||= AppRepository.new(ROM.env).find params['a']
  rescue ROM::TupleCountMismatchError => err
    Bugsnag.notify 'Unknown application', app_id: params['a']
    fail err
  end

  def buildEntities
    fail "No suffixed type: #{params}" unless params["t0"].present?
    suffix = 0
    entities = []
    while params["t#{suffix}"].present? do
      entities << PageEventEntity.build( params, suffix )
      suffix += 1
    end
    entities
  end

  def create_visit_events!
    vee = VisitEventEntity.build params

    add_host vee
    add_page vee

    case vee.type
    when '0'
      create_user! vee
    when '1'
      create_session! vee, true
    when '2'
      create_visit! vee, true
    else
      Bugsnag.notify "Unknown visit event type #{vee.type}",
        metaData: { visit_event: vee.as_json }
    end
  end

  def add_host(vee)
    AppHost.create app_id: vee.appId, host: vee.domain
  rescue ActiveRecord::RecordNotUnique
    nil
  end

  def add_page(vee)
    AppPage.create app_id: vee.appId, host: vee.domain, path: vee.path.presence || '/'
  rescue ActiveRecord::RecordNotUnique
    nil
  end

  def create_user!(vee)
    user = AppUser.create! app_id: vee.appId, userId: vee.userId

    create_session! vee

    user
  end

  def create_session!(vee, direct = false)
    session = AppUserSession.create!(
      app_id:     vee.appId,
      userId:     vee.userId,
      sessionId:  vee.sessionId,
      user_agent: user_agent
    )

    increment_user_sessions vee
    update_user vee unless direct

    create_visit! vee

    session
  end

  def increment_user_sessions(vee)
    AppUser.connection
      .exec_query(
      'update app_users set sessions_count = sessions_count + 1 where app_id = $1 and "userId" = $2',
      'increment sessions_count',
      [[nil, vee.appId], [nil, vee.userId]]
    )
  end

  def increment_session_visits(vee)
    AppUserSession.connection
      .exec_query(
      'update app_user_sessions set visits_count = visits_count + 1 where app_id = $1 and "userId" = $2 and "sessionId" = $3',
      'increment visits_count',
      [[nil, vee.appId], [nil, vee.userId], [nil, vee.sessionId]]
    )
  end

  def increment_visit_page_events(vee)
    AppUserVisit.connection
      .exec_query(
      'update app_user_visits set page_events_count = page_events_count + 1 where app_id = $1 and "userId" = $2 and "sessionId" = $3 and "visitId" = $4',
      'increment page_events_count',
      [[nil, vee.appId], [nil, vee.userId], [nil, vee.sessionId], [nil, vee.visitId]]
    )
    AppUserSession.connection
      .exec_query(
      'update app_user_sessions set page_events_count = page_events_count + 1 where app_id = $1 and "userId" = $2 and "sessionId" = $3',
      'increment page_events_count',
      [[nil, vee.appId], [nil, vee.userId], [nil, vee.sessionId]]
    )
  end

  def update_user(vee)
    AppUser.
      where(app_id: vee.appId, userId: vee.userId).
      where('updated_at<?', time).
      update_all updated_at: time
  end

  def update_session(vee)
    AppUserSession.
      where(app_id: vee.appId, userId: vee.userId, sessionId: vee.sessionId).
      where('updated_at<?', time).
      update_all updated_at: time
    update_user vee
  end

  def update_visit(vee)
    AppUserVisit.
      where(app_id: vee.appId, userId: vee.userId, sessionId: vee.sessionId, visitId: vee.visitId).
      where('updated_at<?', time).
      update_all updated_at: time
    update_session vee
  end

  def create_visit!(vee, direct = false)
    attrs = {
      time:                 vee.timestamp,
      app_id:               vee.appId,
      userId:               vee.userId,
      sessionId:            vee.sessionId,
      visitId:              vee.visitId,

      fragment:             vee.fragment,
      path:                 vee.path,
      query:                vee.query,
      domain:               vee.domain,

      title:                vee.title,

      referer:              vee.referer,
      referer_search_query: vee.referer_search_query,

      utm_source:           vee.utm_source,
      utm_medium:           vee.utm_medium,
      utm_content:          vee.utm_content,
      utm_term:             vee.utm_term,
      utm_campaign:         vee.utm_campaign
    }

    visit = AppUserVisit.create! attrs
    update_session vee unless direct

    increment_session_visits vee
    visit
  end

  def create_page_event!(vee)
    event = AppPageEvent.create!(
      time:            vee.timestamp,

      app_id:          vee.appId,
      userId:          vee.userId,
      sessionId:       vee.sessionId,
      visitId:         vee.visitId,

      event_type:      vee.type,

      element_classes: vee.element_classes,
      element_tag:     vee.element_tag,
      element_id:      vee.element_id,

      dom_path:        vee.dom_path,
      href:            vee.href,
      inner_text:      vee.inner_text
    )

    consider_event_definition event

    update_visit vee

    increment_visit_page_events vee

    event
  end

  def consider_event_definition(page_event)
    event_definitions(page_event).each do |ed|
      ed.apply! page_event
    end
  end

  def event_definitions(page_event)
    EventDefinition
      .where(app_id: page_event.app_id, event_type: page_event.event_type)
      .where('href is null or href = ?', page_event.href)
      .where('element_tag is null or element_tag = ?', page_event.element_tag)
      .where('element_id is null or element_id = ?', page_event.element_id)
      .where('inner_text is null or inner_text = ?', page_event.inner_text)
    # TODO
    # .where('element_classes is null or element_classes = ARRAY[?]', page_event.element_classes)
    # .where('dom_path is null or dom_path = ARRAY[?]', page_event.dom_path)
  end
end
