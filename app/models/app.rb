class App < ActiveRecord::Base
  has_many :app_events
  has_many :app_page_events

  has_many :app_users
  has_many :app_user_sessions
  has_many :app_user_visits

  has_many :event_definitions

  def to_s
    "app-#{id}"
  end
end
