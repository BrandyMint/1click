class SessionsController < ApplicationController
  include CurrentUser
  skip_before_action :verify_authenticity_token

  layout 'system'

  def new
    render locals: { login_form: login_form }
  end

  def create
    if login_form.valid?
      set_current_user login_form.user

      redirect_to apps_path
    else
      render :new, locals: { login_form: login_form }
    end
  end

  private

  def login_form
    @login_form ||= LoginForm.new params.require(:login_form).permit!
  rescue ActionController::ParameterMissing
    LoginForm.new
  end
end
