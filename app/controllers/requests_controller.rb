class RequestsController < ApplicationController
  skip_before_action :verify_authenticity_token

  layout 'welcome'

  def create
    r = Request.create! site: params[:SITE], email_or_phone: params[:EMAIL]

    render locals: { r: r }
  end
end
