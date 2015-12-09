class AppUserMapper < ROM::Mapper
  relation :app_users

  register_as :app_user

  # specify model and attributes ie
  #
  # model AppUser
  #
  # attribute :name
  # attribute :email
end
