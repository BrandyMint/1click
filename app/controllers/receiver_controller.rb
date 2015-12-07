class ReceiverController < ApplicationController
  def create
    # TODO логируем запрос

    EventCreator.create! request

    send_file Rails.root.join("public/r.#{params[:format]}")
  end
end
