class AppsController < ApplicationController
  def index
    render locals: { apps: apps }
  end

  def switch
    app = AppRepository.new(ROM.env).find params[:id]

    redirect_to app.dashboard_url
  end

  private

  def apps
    AppRepository.new(ROM.env).all_apps.as(:app)
  end
end
