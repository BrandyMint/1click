module CurrentApplication
  extend ActiveSupport::Concern

  included do
    helper_method :current_app
  end

  private

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
    return unless session[:app_id].present?

    App.find session[:app_id]
    # Thread.current[:app]
  end
end
