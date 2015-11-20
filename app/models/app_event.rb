class AppEvent < ActiveRecord::Base
  def inspect
    "#{created_at} #{params}"
  end
end
