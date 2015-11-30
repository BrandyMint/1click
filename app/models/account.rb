class Account < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  has_many :apps
end
