class AppPageEventsController < ApplicationController
  include AppUserVisitHelper
  include AppUserHelper
  include AppUserSessionHelper

  def index
    render locals: { events: app_page_events }
  end

  private

  def app_page_events
    if params[:visitId].present?
      scope = AppPageEvent.where visitId: params[:visitId]
    elsif params[:sessionId].present?
      scope = AppPageEvent.where sessionId: params[:sessionId]
    elsif params[:userId].present?
      scope = AppPageEvent.where userId: params[:userId]
    else
      scope = AppPageEvent.all
    end
    scope.order('created_at desc')
  end
end
