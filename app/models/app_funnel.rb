class AppFunnel < ActiveRecord::Base
  belongs_to :app

  has_many :app_funnel_event_definitions

  accepts_nested_attributes_for :app_funnel_event_definitions, reject_if: :all_blank, allow_destroy: true

  def to_s
    title
  end

  def title
    super.presence || "Воронка #{id}"
  end
end
