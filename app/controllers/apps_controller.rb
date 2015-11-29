class AppsController < ApplicationController
  def index
    render locals: { apps: App.order(:id) }
  end

  def switch
    app = App.find params[:id]

    redirect_to app.dashboard_url
  end
end
