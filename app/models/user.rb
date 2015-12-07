class User < ActiveRecord::Base
  # authenticates_with_sorcery!

  has_many :memberships
  has_many :accounts, through: :memberships
  has_many :apps,     through: :accounts

  #validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  #validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  #validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  validates :email, uniqueness: true

  def valid_password?(pwd)
    pin_code == pwd
  end

  def is_superadmin?
    id == 1
  end
end
