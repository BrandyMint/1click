class EventWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(user_agent:, query_string:)
    EventCreator.create! user_agent: user_agent, query_string: query_string
  end
end
