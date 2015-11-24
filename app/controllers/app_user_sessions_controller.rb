class AppUserSessionsController < ApplicationController
  include AppUserHelper

  def index
    render locals: { sessions: current_app_user_sessions }
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
