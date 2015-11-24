class EventDefinition < ActiveRecord::Base
  belongs_to :app, counter_cache: true
  has_many :event_applies, dependent: :delete_all

  validates :title, presence: true
  validates :event_type, presence: true

  def apply!(page_event)
    event_applies.create! app_page_event: page_event, app_id: app_id, time: page_event.time
  end
end
