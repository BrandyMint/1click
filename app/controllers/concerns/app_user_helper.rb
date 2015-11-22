module AppUserHelper
  extend ActiveSupport::Concern

  included do
    helper_method :app_user
  end

  private

  def app_user
    return unless params[:userId]

    AppUser.where(userId: params[:userId]).first!
  end
end
