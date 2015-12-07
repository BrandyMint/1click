class App::AppUserVisitsController < App::ApplicationController
  include AppUserHelper
  include AppUserSessionHelper

  def index
    render locals: { visits: current_app_user_visits.page(params[:page]) }
  end

  private

  def current_app_user_visits
    if params[:userId].present?
      scope = AppUserVisit.where userId: params[:userId]
    elsif params[:sessionId].present?
      scope = AppUserVisit.where sessionId: params[:sessionId]
    else
      scope = current_app.app_user_visits
    end
    scope.order('created_at desc')
  end
end
