ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def setup
    DatabaseCleaner.start
    conn = ROM.env.gateways[:default].connection
    DatabaseCleaner[:sequel, connection: conn].strategy = :transaction
    DatabaseCleaner[:sequel, connection: conn].clean_with(:truncation)
  end

  def teardown
    conn = ROM.env.gateways[:default].connection

    # DatabaseCleaner[:sequel, connection: conn].clean #ing { example.run }
    DatabaseCleaner.clean
  end
  # Add more helper methods to be used by all tests here...
end
