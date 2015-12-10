class AppMapper < ROM::Mapper
  relation :apps

  register_as :app

  # specify model and attributes ie
  #
  model App
  #
  # attribute :title
  # attribute :email
end
