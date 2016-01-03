class ReceiverController < ApplicationController

  # НЕ понимаю почему оно валитя
  skip_before_action :verify_authenticity_token

  def create
    # DO Nothing
    EventWorker.perform_async request.user_agent, request.query_string
    send_file Rails.root.join("public/r.#{params[:format]}"), filename: "a.#{params[:format]}"
  rescue => err
    Bugsnag.notify err
    send_file Rails.root.join("public/error.#{params[:format]}")
  end
end
