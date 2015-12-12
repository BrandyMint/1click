require 'test_helper'

# Список отправляемых полей
# https://github.com/BrandyMint/aristotel/wiki/Список-отправляемых-полей

class AppIdentifyCreatorTest < ActiveSupport::TestCase
  def test_1
    handle = 'dapi@mail.ru'
    data1 = Sequel::Postgres::HStore.new name: 'Vasily'
    identify1 = AppIdentify.new app_id: 1, userId: 2, sessionId: 3, visitId: 4, handle: handle, data: data1
    userId = AppIdentifyCreator.create identify1

    data2 = Sequel::Postgres::HStore.new phone: '123'
    identify2 = AppIdentify.new app_id: 1, userId: 3, sessionId: 4, visitId: 5, handle: handle, data: data2
    userId2 = AppIdentifyCreator.create identify2

    user = AppIdentifiedUsersRepository.new(ROM.env).find app_id: 1, handle: handle

    user = ROM.env.relations[:app_identified_users].where(app_id: 1, handle: handle).first

    assert_equal user[:data], { 'name' => 'Vasily', 'phone' => '123'}
    assert_equal userId, 2
    assert_equal userId, userId2, 'так как handle один, то должен вернуться тот-же юзер'
  end
end
