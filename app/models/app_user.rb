class AppUser < ActiveRecord::Base

  def to_s
    "#{created_at} пользователь #{userId}, визитов #{sessions_count}"
  end
end
