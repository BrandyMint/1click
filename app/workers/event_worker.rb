class EventWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(opts)
    EventCreator.create! user_agent: opts[:user_agent], query_string: opts[:query_string]
  end
end
