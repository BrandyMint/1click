class AppIdentifiedUsersRepository < ROM::Repository::Base
  relations :app_identified_users

  def find(app_id:, handle:)
    app_identified_users
      .find_by_handle(app_id: app_id, handle: handle)
  end
end
