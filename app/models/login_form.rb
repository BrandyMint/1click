class LoginForm < ActiveType::Object
  attribute :login
  attribute :password

  validates :login,    presence: true
  validates :password, presence: true

  validate :authenticate

  def user
    User.where('(phone is not null and phone = ?) or (email is not null and email = ?)', login, login).first
  end

  private

  def authenticate
    return unless login.present? && password.present?
    if user.present?
      errors.add :password, "Неверный пароль" unless user.valid_password? password
    else
      errors.add :login, "Не найден пользователь с таким емайлом или телефоном"
    end
  end
end
