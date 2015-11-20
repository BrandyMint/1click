class EventCreator
  include Singleton

  def self.create!(params:, request:)
    instance.create! params: params, request: request
  end

  def create!(params:, request:)

    # TODO
    # AppEvent.transaction do
    AppEvent.create!(
      app_id:     params['a'],
      params:     params,
      user_agent: request.user_agent
    )

    if params['t'].present?
      create_visit_events! params, request
    else
      entities = buildEntities params
      entities.map do |e|
        create_event! e
      end
    end
  end

  private

  def buildEntities(params)
    fail "No suffixed type: #{params}" unless params["t0"].present?
    suffix = 0
    entities = []
    while params["t#{suffix}"].present? do
      entities << InnerEventEntity.build( params, suffix )
      suffix += 1
    end
    entities
  end

  def create_visit_events!(params, request)
    vee = VisitEventEntity.build params

    case vee.type
    when '0'
      create_user!  vee, request
    when '1'
      create_session! vee, request, true
    when '2'
      create_visit! vee, true
    else
      Bugsnag.notify "Unknown visit event type #{vee.type}",
        metaData: { visit_event: vee.as_json }
    end
  end

  def create_user!(vee, request)
    user = AppUser.create! app_id: vee.appId, userId: vee.userId

    create_session! vee, request
    create_visit! vee

    user
  end

  def create_session!(vee, request, direct = false)
    session = AppUserSession.create!(
      app_id:     vee.appId,
      userId:     vee.userId,
      sessionId:  vee.sessionId,
      user_agent: request.user_agent
    )
    AppUser.increment_counter :sessions_count, 1

    update_user vee unless direct

    create_visit! vee

    session
  end

  def update_user(vee)
    AppUser.where(app_id: vee.appId, userId: vee.userId).update_all updated_at: Time.now
  end

  def update_session(vee)
    AppUserSession.where(app_id: vee.appId, userId: vee.userId, sessionId: vee.sessionId).update_all updated_at: Time.now
    update_user vee
  end

  def update_visit(vee)
    AppUserVisit.where(app_id: vee.appId, userId: vee.userId, sessionId: vee.sessionId, visitId: vee.visitId).update_all updated_at: Time.now
    update_session vee
  end

  def create_visit!(vee, direct = false)
    attrs = {
      time:                 vee.timestamp,
      app_id:               vee.appId,
      userId:               vee.userId,
      sessionId:            vee.sessionId,
      visitId:              vee.visitId,

      location_hash:        vee.location_hash,
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
    AppUserSession.increment_counter :visits_count, 1

    visit
  end

  def create_event!(vee)
    event = AppInnerEvent.create!(
      time: vee.timestamp,

      app_id:               vee.appId,
      userId:               vee.userId,
      sessionId:            vee.sessionId,
      visitId:              vee.visitId,

      event_type: vee.type,

      element_classes: vee.element_classes,
      element_tag: vee.element_tag,
      element_id: vee.element_id,

      dom_path: vee.dom_path,
      href: vee.href,
      inner_text: vee.inner_text
    )

    update_visit vee

    event
  end
end
