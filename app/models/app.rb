class App < ActiveRecord::Base
  has_many :app_events

  has_many :app_users
  has_many :app_user_sessions
  has_many :app_user_visits
  has_many :app_page_events

  has_many :event_definitions

  def to_s
    "app-#{id}"
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
