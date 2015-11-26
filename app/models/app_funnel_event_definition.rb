class AppFunnelEventDefinition < ActiveRecord::Base
  belongs_to :app_funnel
  belongs_to :event_definition

  delegate :users_count, to: :event_definition
  delegate :events_count, to: :event_definition

  def to_s
    event_definition.to_s
  end
end
