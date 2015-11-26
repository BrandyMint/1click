module OneClickSupport
  ONECLICK_COOKIE_PREFIX = '_art_id.'

  # userId.visitId.sessionId
  # "_art_id.1"=>"4105334173779580.2741553297.1328479166"

  protected

  def oneclick_cookie
    cookies[oneclick_cookie_name]
  end

  def oneclick_cookie_name
    "_art_id.#{oneclick_app_id}"
  end

  def oneclick_id
    oneclick_cookie.split('.')
  end

  def oneclick_user_id
    oneclick_id.first
  end

  def oneclick_visit_id
    oneclick_id.second
  end

  def oneclick_session_id
    oneclick_id.third
  end

  def oneclick_app_id
    @oneclick_app_id ||= cookies
      .to_h
      .keys
      .select { |n| n.start_with? ONECLICK_COOKIE_PREFIX }
      .first
      .try :sub, ONECLICK_COOKIE_PREFIX, ''
  end
end
