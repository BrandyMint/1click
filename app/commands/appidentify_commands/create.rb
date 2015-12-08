module AppIdentifyCommands
  class Create < ROM::Commands::Create[:sql]
    relation :app_identifies
    register_as :create
    result :one

    def execute(app_id:, handle:, sessionId:, visitId:, userId:, email: nil)
      aiu = ROM.env
        .command(:app_identified_users).as(:app_identified_user)
        .find_or_create
        .call app_id: app_id, handle: handle, userId: userId, email: email

      super(
        created_at: Time.now,
        updated_at: Time.now,
        app_id:    app_id,
        sessionId: sessionId,
        visitId:   visitId,
        userId:    userId,
        handle:    handle,
        email:     email,
        handledUserId: aiu.userId
      )
    end
  end
end
