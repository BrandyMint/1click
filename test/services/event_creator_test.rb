require 'test_helper'

# Список отправляемых полей
# https://github.com/BrandyMint/aristotel/wiki/Список-отправляемых-полей

class EventCreatorTest < ActiveSupport::TestCase

  USER_AGENT = 'mozilla'

  def self.app_id
    1
  end

  def setup
    ROM.
      env.
      command(:apps).
      create.
      call App.new(id: 1, account_id: 1)
  end

  PARAMS_TYPE_0 = {"a"=>app_id, "d"=>"rawgit.com", "g"=>"Test Title", "m"=>"web", "p"=>"/BrandyMint/aristotel/master/example/test.html", "r"=>"http://3009.vkontraste.ru/", "s"=>"1034253649", "t"=>"0", "u"=>"7158547617168538", "v"=>"1193048213", "tm"=>"1448005969822"}

  PARAMS_TYPE_1 = {"a"=>app_id, "d"=>"rawgit.com", "g"=>"Test Title", "m"=>"web", "p"=>"/BrandyMint/aristotel/master/example/test.html", "s"=>"2564470158", "t"=>"1", "u"=>"8992569949901988", "v"=>"0435525828", "tm"=>"1448003913978", "r"=>"http://rawgit.com/BrandyMint/aristotel/master/example/test.html"}

  PARAMS_TYPE_2 = {"a"=>app_id, "d"=>"rawgit.com", "g"=>"Test Title", "m"=>"web", "p"=>"/BrandyMint/aristotel/master/example/test.html", "s"=>"2564470158", "t"=>"2", "u"=>"8992569949901988", "v"=>"1906698993", "tm"=>"1448004295028"}

  PARAMS_CLICK = {"a"=>app_id, "m"=>"web", "s"=>"2564470158", "u"=>"8992569949901988", "v"=>"1906698993", "f0"=>"http://3009.vkontraste.ru/", "n0"=>"a", "t0"=>"click", "tm"=>"1448004407914", "w0"=>"@a;|", "x0"=>"3009.vkontraste.ru"}

  PARAMS_CLICK_AND_SUBMIT = {"a"=>app_id, "m"=>"web", "s"=>"2564470158", "u"=>"8992569949901988", "v"=>"0918849231", "l0"=>"submit-class", "n0"=>"input", "n1"=>"form", "t0"=>"click", "t1"=>"submit", "tm"=>"1448005511465", "w0"=>"@form;|@input;.submit-class;|", "w1"=>"@form;|", "x1"=>"форма тестовая\n\nлейбл для поля"}

  test 'Клик и сабмит' do
    events = EventCreator.create! user_agent: USER_AGENT, query_string: PARAMS_CLICK_AND_SUBMIT.to_query

    assert_equal 2, events.count

    entity_click = events.first
    entity_submit = events.second
    assert_instance_of AppPageEvent, entity_click
    assert_instance_of AppPageEvent, entity_submit

    assert_equal 'click', entity_click.event_type
    assert_equal 'submit', entity_submit.event_type

    assert_equal ['@form;','@input;.submit-class;'], entity_click.dom_path
    assert_equal ['@form;'], entity_submit.dom_path
  end

  test 'Клик' do
    events = EventCreator.create! user_agent: USER_AGENT, query_string: PARAMS_CLICK.to_query

    assert_instance_of Array, events
    event = events.first
    assert_instance_of AppPageEvent, event
    assert_instance_of Array, event.element_classes

    assert_equal [], event.element_classes
    assert_equal ['@a;'], event.dom_path
    assert_equal 'click', event.event_type
  end

  test 'Новый пользователь' do
    event = EventCreator.create! user_agent: USER_AGENT, query_string: PARAMS_TYPE_0.to_query

    assert_instance_of AppUser, event
  end

  test 'Новый визит' do
    event = EventCreator.create! user_agent: USER_AGENT, query_string: PARAMS_TYPE_2.to_query

    assert_equal 'rawgit.com', event.domain
    assert_instance_of AppUserVisit, event
  end

  test 'Новая сессия' do
    event = EventCreator.create! user_agent: USER_AGENT, query_string: PARAMS_TYPE_1.to_query

    #assert_equal 'rawgit.com', event.domain
    assert_instance_of AppUserSession, event
  end

  def teardown
    # TODO delete app
  end
end
