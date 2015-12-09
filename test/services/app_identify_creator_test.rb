require 'test_helper'

# Список отправляемых полей
# https://github.com/BrandyMint/aristotel/wiki/Список-отправляемых-полей

class AppIdentifyCreatorTest < ActiveSupport::TestCase
  def setup
    super
    @account = Account.create id: 1, host: 'host'
    @app = ROM.env.command(:apps).as(:app).create.call App.new id: 1, account_id: 1, host: 'host'
  end

  #def test_1
    #ai = AppIdentifyCreator
      #.create AppIdentify.new app_id: 1, userId: 2, sessionId: 3, visitId: 4, handle: 'dapi@mail.ru'

    #ai2 = AppIdentifyCreator
      #.create AppIdentify.new app_id: 1, userId: 3, sessionId: 4, visitId: 5, handle: 'dapi@mail.ru'

    #assert_equal ai, ai2
  #end

  def test_2
    AppIdentifyCreator
      .new( AppIdentify.new app_id: 1, userId: 3, sessionId: 4, visitId: 5, handle: 'dapi@mail.ru' )
      .create
  end
end
