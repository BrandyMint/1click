class AppIdentifiedUserMapper < ROM::Mapper
  relation :app_identified_users

  register_as :app_identified_user

  # specify model and attributes ie
  #
  model AppIdentifiedUser
  #
  # attribute :name
  # attribute :email
end
