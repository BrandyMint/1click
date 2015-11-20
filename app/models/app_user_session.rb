class AppUserSession < ActiveRecord::Base
  belongs_to :app

  def visits
    @visits = AppUserVisit.where(sessionId: sessionId, app_id: app_id).order(:time)
  end

  def to_s
    "#{created_at} пользователь #{userId}, визитов #{visits_count}"
  end
end
