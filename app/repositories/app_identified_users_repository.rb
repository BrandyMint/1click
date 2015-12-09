class AppIdentifiedUsersRepository < ROM::Repository::Base
  relations :app_identified_users

  def find_or_create(identify)
    identified_user = app_identified_users
      .find_by_handle(identify.app_id, identify.handle)
      .as(:app_identified_user)
      .one
    return identified_user if identified_user.present?

    identified_user = AppIdentifiedUser.new identify

    ROM.env
      .command(:app_identified_users)
      .as(:app_identified_user)
      .create
      .call identified_user
  end
end
