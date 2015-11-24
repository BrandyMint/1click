class EventApply < ActiveRecord::Base
  belongs_to :app
  belongs_to :event_definition, counter_cache: :events_count
  belongs_to :app_page_event
end
