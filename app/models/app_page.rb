class AppPage < ActiveRecord::Base
  belongs_to :app

  def to_s
    "#{host}#{path}"
  end
end
