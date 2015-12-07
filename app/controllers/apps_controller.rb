class AppsController < ApplicationController
  def index
    render locals: { apps: apps }
  end

  def switch
    app = App.find params[:id]

    redirect_to app.dashboard_url
  end

  private

  def apps
    ROM.env.relation(:apps).as(:app)
  end
end
