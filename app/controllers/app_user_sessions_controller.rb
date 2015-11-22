class AppUserSessionsController < ApplicationController
  include AppUserHelper

  def index
    render locals: { sessions: app_user_sessions }
  end

  private

  def app_user_sessions
    if params[:userId].present?
      scope = AppUserSession.where userId: params[:userId]
    else
      scope = AppUserSession
    end
    scope.order('created_at desc')
  end
end
