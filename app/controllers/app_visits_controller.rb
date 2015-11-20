class AppVisitsController < ApplicationController
  def index
    render locals: { events: AppVisit.order('created_at desc') }
  end
end
