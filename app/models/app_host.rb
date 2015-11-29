class AppHost < ActiveRecord::Base
  belongs_to :app

  def to_s
    host
  end
end
