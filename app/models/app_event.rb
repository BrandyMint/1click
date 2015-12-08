class AppEvent < ActiveRecord::Base
  def inspect
    "#{created_at} #{query}"
  end
end
