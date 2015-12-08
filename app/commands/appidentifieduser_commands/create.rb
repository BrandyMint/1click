module AppIdentifiedUserCommands
  class Create < ROM::Commands::Create[:sql]
    relation :app_identified_users
    register_as :find_or_create
    result :one

    def execute(app_id:, handle:, userId:, email: nil)
      user = ROM.env.relation(:app_identified_users)
        .find_by_handle(app_id, handle)
        .as(:app_identified_user)
        .one

      if user
        return [user]
      else
        super(
          created_at: Time.now,
          updated_at: Time.now,
          app_id: app_id,
          email:  email,
          handle: handle,
          userId: userId
        )
      end
    end
  end
end
