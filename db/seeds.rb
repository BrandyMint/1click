# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_by_name 'admin'

unless user.present?
  user = User.create! name: 'admin', email: 'danil@brandymint.ru', phone: '79033891228', password: 'oneclick'
end

account = Account.find_or_create!( host: 'test' )

account.memberships.create! user: user unless account.users.include? user

app = App.find_or_create_by id: 1

app.event_definitions.destroy_all

app.event_definitions.create! title: 'Клик на любой ссылке', element_tag: :a, event_type: 'click'
app.event_definitions.create! title: 'Отправка любой формы', event_type: 'submit'
