class App::AppPageEventsController < App::ApplicationController
  include AppUserVisitHelper
  include AppUserHelper
  include AppUserSessionHelper

  def index
    render locals: { events: current_app_page_events.page(params[:page]) }
  end

  private

  def current_app_page_events
    if params[:visitId].present?
      scope = app_page_events.where visitId: params[:visitId]
    elsif params[:sessionId].present?
      scope = app_page_events.where sessionId: params[:sessionId]
    elsif params[:userId].present?
      scope = app_page_events.where userId: params[:userId]
    else
      scope = app_page_events
    end
    scope.order('created_at desc')
  end
end
