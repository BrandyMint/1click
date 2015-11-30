class App::AppUserSessionsController < App::ApplicationController
  include AppUserHelper

  def index
    render locals: { sessions: current_app_user_sessions.page(params[:page]) }
  end

  private

  def current_app_user_sessions
    if params[:userId].present?
      scope = AppUserSession.where userId: params[:userId]
    else
      scope = AppUserSession.all
    end
    scope.order('created_at desc')
  end
end
