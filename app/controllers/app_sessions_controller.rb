class AppSessionsController < ApplicationController
  def index
    render locals: { sessions: AppUserSession.order('created_at desc') }
  end
end
