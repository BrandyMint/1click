class EventDefinition < ActiveRecord::Base
  belongs_to :app, counter_cache: true

  validates :title, presence: true
  validates :event_type, presence: true
end
