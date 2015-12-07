# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_by_name 'admin'

unless user.present?
  user = User.create! name: 'admin', email: 'danil@brandymint.ru', phone: '79033891228', password: 'oneclick', pin_code: '123'
end

account = Account.find_or_create_by host: 'test'

account.memberships.create! user: user unless account.users.include? user

app = AppRepository.new(ROM.env).find 1
unless app
  app = ROM.env.command(:apps).as(:app).create.call id: 1, created_at: Time.now, updated_at: Time.now, account_id: account.id
end

# app.event_definitions.destroy_all

EventDefinition.create! app_id: app.id, title: 'Клик на любой ссылке', element_tag: :a, event_type: 'click'
EventDefinition.create! app_id: app.id, title: 'Отправка любой формы', event_type: 'submit'
