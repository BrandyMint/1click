# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
app = App.find_or_create_by id: 1, title: 'test'

app.event_definitions.destroy_all

app.event_definitions.create! title: 'Клик на любой ссылке', element_tag: :a, event_type: 'click'
app.event_definitions.create! title: 'Отправка любой формы', event_type: 'submit'
