class EventWorker
  def perform(user_agent:, query_string:)
    EventCreator.create! user_agent: user_agent, query_string: query_string
  end
end
