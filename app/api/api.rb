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
      requires :a, type: String
      requires :u, type: String
      optional :v, type: String, desc: 'Обазятельный и передается параметром, но кривой grape упорно хочет его видеть в path'
      requires :s, type: String
      optional :k, type: String
    end
    get do
      newUserId = AppIdentifyCreator.create app_id: a, userId: u, visitorId: u, sessionId: s
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
