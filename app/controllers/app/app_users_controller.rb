class App::AppUsersController < App::ApplicationController
  def index
    render locals: { users: app_users.page(params[:page]).order('created_at desc') }
  end

  def show
    render locals: { app_user: app_users.where(userId: params[:id]).first! }
  end
end
