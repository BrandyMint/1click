class App < ActiveRecord::Base
  belongs_to :account

  has_many :app_events

  has_many :app_users
  has_many :app_user_sessions
  has_many :app_user_visits
  has_many :app_page_events

  has_many :app_hosts
  has_many :app_pages

  has_many :event_definitions

  has_many :app_funnels

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
    app_hosts.first
  end

  def app_users_count
    app_users.count
  end

  def app_user_sessions_count
    app_user_sessions.count
  end

  def app_user_visits_count
    app_user_visits.count
  end

  def app_page_events_count
    app_page_events.count
  end
end
