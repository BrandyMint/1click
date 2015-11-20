class AppUsersController < ApplicationController
  def index
    render locals: { users: AppUser.order('created_at desc') }
  end
end
