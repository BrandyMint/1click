class AppIdentifyMapper < ROM::Mapper
  relation :app_identifies

  register_as :app_identify

  # specify model and attributes ie
  #
  model AppIdentify
  #
  # attribute :name
  # attribute :email
end
