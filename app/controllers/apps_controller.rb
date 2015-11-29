class AppsController < ApplicationController
  def index
    render locals: { apps: App.order(:id) }
  end

  def switch
    session[:app_id] = params[:id]

    redirect_to dashboard_path
  end
end
