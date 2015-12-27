class ReceiverController < ApplicationController

  # НЕ понимаю почему оно валитя
  skip_before_action :verify_authenticity_token

  def create
    # TODO логируем запрос

    # Отключил потому что тормозит
    # EventCreator.create! request

    send_file Rails.root.join("public/r.#{params[:format]}"), filename: "a.#{params[:format]}"
  rescue => err
    Bugsnag.notify err
    send_file Rails.root.join("public/error.#{params[:format]}")
  end
end
