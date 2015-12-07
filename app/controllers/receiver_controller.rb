class ReceiverController < ApplicationController

  # НЕ понимаю почему оно валитя
  skip_before_action :verify_authenticity_token

  def create
    # TODO логируем запрос

    EventCreator.create! request

    send_file Rails.root.join("public/r.#{params[:format]}")
  end
end
