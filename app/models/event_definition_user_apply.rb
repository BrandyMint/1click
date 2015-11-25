class EventDefinitionUserApply < ActiveRecord::Base
  belongs_to :app
  belongs_to :event_definition, counter_cache: :users_count
  belongs_to :app_page_event

  def user
    @user ||= AppUser.find_by app_id: app_id, userId: userId
  end
end
