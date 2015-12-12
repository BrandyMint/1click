class VisitEventEntity < BaseEventEntity
  SHORTS = {
    t: :type,    # 0, 1, 2
    h: :fragment,
    p: :path,
    q: :query,
    d: :domain,
    g: :title,

    r: :referer,
    e: :referer_search_query,

    us: :utm_source,
    um: :utm_medium,
    ut: :utm_term,
    uc: :utm_content,
    ug: :utm_campaign
  }

  SHORTS.values.each { |v| attribute v }

  def self.build(params)
    e = new
    BASE_SHORTS.merge(SHORTS).each do |short, long|
      e.send "#{long}=", params[short.to_s]
    end
    e
  end

  def domain
    super.to_s.downcase
  end

  def user?
    type == '0'
  end

  def session?
    type == '1'
  end

  def visit?
    type == '2'
  end

  def to_s
    super + " #{domain}/#{path}?#{query}##{hash} referer:#{referer}"
  end
end
