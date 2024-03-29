module CurrentApplication
  extend ActiveSupport::Concern

  included do
    helper_method :current_app
    helper_method :app_users
    helper_method :app_user_visits
    helper_method :app_user_sessions
    helper_method :app_page_events
    helper_method :app_events

    helper_method :app_hosts
    helper_method :app_pages

    helper_method :app_event_definitions
    helper_method :app_funnels
  end

  private

  def app_funnels
    current_app.app_funnels
  end

  def app_event_definitions
    current_app.event_definitions
  end

  def app_pages
    if current_app.present?
      current_app.app_pages
    else
      AppPage.all
    end
  end

  def app_hosts
    if current_app.present?
      current_app.app_hosts
    else
      AppHost.all
    end
  end

  def app_users
    if current_app.present?
      current_app.app_users
    else
      AppUser.all
    end
  end

  def app_user_visits
    if current_app.present?
      current_app.app_user_visits
    else
      AppUserVisit.all
    end
  end

  def app_user_sessions
    if current_app.present?
      current_app.app_user_sessions
    else
      AppUserSession.all
    end
  end

  def app_events
    if current_app.present?
      current_app.app_events
    else
      AppEvent.all
    end
  end

  def app_page_events
    if current_app.present?
      current_app.app_page_events
    else
      AppPageEvent.all
    end
  end

  def current_app
    Thread.current[:app]
  end
end
