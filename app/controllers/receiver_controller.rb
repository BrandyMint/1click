class ReceiverController < ApplicationController
  DEFAULT_ACCOUNT_ID = 1

  # НЕ понимаю почему оно валитя
  skip_before_action :verify_authenticity_token

  before_action :create_app

  # TODO фильтровать по наличию app_id

  def create
    raise 'No app_id' unless app_id.present?
    EventWorker.perform_async user_agent: request.user_agent, query_string: request.query_string
    send_file Rails.root.join("public/r.#{params[:format]}"), filename: "a.#{params[:format]}"
  rescue => err
    Bugsnag.notify err
    send_file Rails.root.join("public/error.#{params[:format]}")
  end

  private

  def app_id
    params[:a]
  end

  def create_app
    return unless app_id.present?
    return if AppRepository.new(ROM.env).find app_id
    ROM.
      env.
      command(:apps).
      create.
      call App.new(id: app_id, account_id: DEFAULT_ACCOUNT_ID)
  end
end
