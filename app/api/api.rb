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
    helpers do
      def data
        Sequel::Postgres::HStore.new params.except(:m, :a, :h, :u, :s, :v, :e, :route_info, :callback)
      end

      def identify
        @identify ||= AppIdentify.new(
          app_id: params[:a],
          handle: params[:h],
          userId: params[:u],
          sessionId: params[:s],
          visitId: params[:v],
          email: params[:e],
          data: data
        )
      end
    end
    params do
      requires :callback, type: String, desc: 'jsonp callback'
      optional :m, type: String, desc: 'platfowm'
      optional :a, type: Integer
      optional :u, type: Integer
      optional :v, type: Integer, desc: 'Обазятельный и передается параметром, но кривой grape упорно хочет его видеть в path'
      optional :s, type: Integer
      optional :h, type: String, desc: 'handle'
      optional :e, type: String, desc: 'email'
    end
    get do
      newUserId = AppIdentifyCreator.create identify
      "window.#{params[:callback]}({uid: #{newUserId}});"
    end
  end

  add_swagger_documentation api_version: 'v1',
    markdown: GrapeSwagger::Markdown::KramdownAdapter,
    base_path: '',
    hide_documentation_path: true
  # ,
  # models: [API::Entity::GoodsResult, API::Entity::Good]
end
