class App
  include ROM::Model::Attributes

  attribute :id,                      Integer
  attribute :title,                   String
  attribute :event_definitions_count, Integer
  attribute :account_id,              Integer

  attribute :app_users_count,         Integer
  attribute :app_user_sessions_count, Integer
  attribute :app_user_visits_count,   Integer
  attribute :app_page_events_count,   Integer

  timestamps

  def app_events
    AppEvent.where(app_id: id)
  end

  def app_users
    AppUser.where(app_id: id)
  end

  def users
    Account.find(account_id).users
  end

  def app_user_sessions
    AppUserSession.where(app_id: id)
  end

  def app_page_events
    AppPageEvent.where(app_id: id)
  end

  def app_funnels
    AppFunnel.where(app_id: id)
  end

  def event_definitions
    EventDefinition.where(app_id: id)
  end

  def app_pages
    AppPage.where(app_id: id)
  end

  def app_hosts
    AppHost.where(app_id: id)
  end

  def app_user_visits
    AppUserVisit.where(app_id: id)
  end

  #has_many :app_events

  #has_many :app_users
  #has_many :app_user_sessions
  #has_many :app_user_visits
  #has_many :app_page_events

  #has_many :app_hosts
  #has_many :app_pages

  #has_many :event_definitions

  #has_many :app_funnels

  def dashboard_url
    Rails.application.routes.url_helpers.dashboard_url host: dashboard_host
  end

  def dashboard_host
    [ AppConstraint::APP_PREFIX, id, '.', Settings.default_url_options.host ].join
  end

  def to_s
    "app-#{id}: #{default_host}"
  end

  def default_host
    # app_hosts.first
  end
end
