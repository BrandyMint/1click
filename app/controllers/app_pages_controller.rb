class AppPagesController < ApplicationController
  def index
    render locals: { app_pages: app_pages.page(params[:page]).order('path desc') }
  end

  def show
  end
end
