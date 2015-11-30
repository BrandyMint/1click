module AppAuthority
  extend Pundit
  extend ActiveSupport::Concern

  included do
    before_filter :authorize_user!
    rescue_from NoUserError, with: :login
  end

  def login
    render 'sessions/new', locals: { login_form: LoginForm.new }, layout: 'system'
  end

  private

  def authorize_user!
    fail NoUserError unless current_user.present?
    fail AccessError unless current_app.users.include? current_user
  end
end
