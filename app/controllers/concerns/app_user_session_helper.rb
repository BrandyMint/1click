module AppUserSessionHelper
  extend ActiveSupport::Concern

  included do
    helper_method :app_user_session
  end

  private

  def app_user_session
    return unless params[:sessionId]

    AppUserSession.where(sessionId: params[:sessionId]).first!
  end
end
