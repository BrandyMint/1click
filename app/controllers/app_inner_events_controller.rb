class AppInnerEventsController < ApplicationController
  def index
    render locals: { events: AppInnerEvent.order('created_at desc') }
  end
end
