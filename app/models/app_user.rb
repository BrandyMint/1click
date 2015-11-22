class AppUser < ActiveRecord::Base
  def to_s
    userId.to_s
  end

  def visits
    @visits = AppUserVisit.where(app_id: app_id, userId: userId).order('time desc')
  end

  def sessions
    @sessions = AppUserSession.where(app_id: app_id, userId: userId).order('time desc')
  end

  def visits_count
    visits.count
  end

  def page_events
    @page_events = AppPageEvent.where(app_id: app_id, userId: userId).order('time desc')
  end

  def page_events_count
    page_events.count
  end
end
