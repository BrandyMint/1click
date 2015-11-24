class AppEventsController < ApplicationController
  def index
    render locals: { events: app_events.order('created_at desc') }
  end
end
