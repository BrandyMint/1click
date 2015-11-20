class AppEventsController < ApplicationController
  def index
    render locals: { events: AppEvent.order('created_at desc') }
  end
end
