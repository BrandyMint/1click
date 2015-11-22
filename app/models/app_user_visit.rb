class AppUserVisit < ActiveRecord::Base
  belongs_to :app

  def to_s
    visitId.to_s
  end

  def url
    URI::HTTP.build host: domain, path: path, query: query, fragment: fragment
  end
end
