class AppUserSession < ActiveRecord::Base
  belongs_to :app

  def visits
    @visits = AppUserVisit.where(sessionId: sessionId, app_id: app_id, userId: userId).order('time desc')
  end

  def to_s
    sessionId.to_s
  end
end
