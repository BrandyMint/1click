class User < ActiveRecord::Base
  has_many :memberships
  has_many :accounts, through: :memberships
  has_many :apps,     through: :accounts

  def valid_password?(pwd)
    pin_code == pwd
  end

  def is_superadmin?
    id == 1
  end
end
