ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include DBTables

  def setup
    super
    create_app
  end

  def create_app
    @account = Account.create host: 'host'
    @app = App.new id: 1, account_id: @account.id, host: 'host'
    db[:apps].insert @app.to_h
  end

  def run(*args, &block)
    ROM.env.gateways[:default].connection.transaction(:rollback=>:always, :auto_savepoint=>true){super}
  end

  private

  def app_id
    @app.id
  end
end
