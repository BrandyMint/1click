class AppUserVisit < ActiveRecord::Base
  belongs_to :app

  def to_s
    "#{created_at} Посетил страницу #{url} из #{referer}. Внутренних событий #{events_count}"
  end

  def url
    "http://#{domain}/#{path}?#{query}#{location_hash}"
  end
end
