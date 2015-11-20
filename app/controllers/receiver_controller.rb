class ReceiverController < ApplicationController
  def create
    # TODO логируем запрос

    EventCreator.create! params: data, request: request

    send_file Rails.root.join('public/a.gif')
  end

  private

  def data
    params.except(:action, :controller)
  end
end

