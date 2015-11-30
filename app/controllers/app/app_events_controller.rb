class App::AppEventsController < App::ApplicationController
  def index
    render locals: { events: app_events.page(params[:page]).order('created_at desc') }
  end
end
