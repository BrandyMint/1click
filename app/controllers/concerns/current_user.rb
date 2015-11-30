module CurrentUser
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :current_account
    helper_method :current_member
  end

  private

  def set_current_user(user)
    session[:user_id] = user.id
  end

  def current_user
    return unless session[:user_id].present?

    User.find_by_id session[:user_id]
  end

  def current_member
    @current_member ||= current_app.memberships
  end
end
