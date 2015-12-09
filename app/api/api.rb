class API < Grape::API
  # default_format :json

  # С этим не работает swagger
  # format :json
  version 'v1'

  # mount SystemAPI::UserRequests

  # Колбеки для оплаты из W1
  # http://api.kiiiosk.ru/v1/callbacks/w1/payments/:vendor_id/notify
  # mount SystemAPI::PaymentsCallbacks

  # mount APIPing

  resource :identify do
    desc 'identify'
    params do
      requires :callback, type: String, desc: 'jsonp callback'
      requires :a, type: Integer
      requires :u, type: Integer
      optional :v, type: Integer, desc: 'Обазятельный и передается параметром, но кривой grape упорно хочет его видеть в path'
      requires :s, type: Integer
      optional :k, type: String
      requires :h, type: String, desc: 'handle'
      requires :e, type: String, desc: 'email'
      optional :tm, type: Integer
    end
    get do
      identify = AppIdentify.new app_id: app_id, handle: handle, userId: userId, sessionId: sessionId, visitId: visitId, email: email
      newUserId = AppIdentifyCreator.create! identify
      "window.#{params.callback}({uid: #{newUserId}});"
    end
  end

  add_swagger_documentation api_version: 'v1',
    markdown: GrapeSwagger::Markdown::KramdownAdapter,
    base_path: '',
    hide_documentation_path: true
  # ,
  # models: [API::Entity::GoodsResult, API::Entity::Good]
end
