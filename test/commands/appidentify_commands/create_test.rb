require 'test_helper'

class AppIdentifyCommandsCreateTest < ActiveSupport::TestCase
  def setup
    super
    # @account = Account.create id: 1, host: 'host'
    @app = ROM.env.command(:apps).as(:app).create.call App.new id: 1, account_id: 1, host: 'host'
  end

  def test_1
    ai = ROM.env.command(:app_identifies).as(:app_identify)
      .create
      .call app_id: 1, userId: 2, sessionId: 3, visitId: 4, handle: 'dapi@mail.ru'

    ai2 = ROM.env.command(:app_identifies).as(:app_identify)
      .create
      .call app_id: 1, userId: 3, sessionId: 4, visitId: 5, handle: 'dapi@mail.ru'

    assert_equal ai.handleUserId, ai2.handleUserId
  end
end
