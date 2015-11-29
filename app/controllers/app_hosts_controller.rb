class AppHostsController < ApplicationController
  def index
    render locals: { app_hosts: app_hosts.page(params[:page]).order('host desc') }
  end

  def show
  end
end
