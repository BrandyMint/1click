class Request < ActiveRecord::Base
  validates :site, presence: true
  validates :email_or_phone, presence: true
end
