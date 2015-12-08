class AppIdentifyCreator
  def self.create(app_id:, userId:, visitId:, sessionId:)
    new(app_id: app_id, userId: userId, visitId: visitId, sessionId: sessionId)
      .create
  end

  def initialize(app_id:, userId: ,visitId:, sessionId:)
    @app_id = app_id
    @userId = userId
    @visitId = visitId
    @sessionId = sessionId
  end

  def create
    user = relations(:app_identified_users)
      .find_by_handle(app_id, handle)

    if user
      handledUserId = user.userId
    else
      commands(:app_identified_users).create.call app_id: app_id, handle: handle, userId: userId
      handledUserId = userId
    end

    commands(:app_identifies).create
      .call(
      app_id:    app_id,
      sessionId: sessionId,
      visitId:   visitId,
      userId:    userId,
      handledUserId: handledUserId
    )
  end

  private

  attr_reader :app_id, :userId, :visitId, :sessionId

  def commands(cmd)
    ROM.env.commands(cmd)
  end

  def relations(rel)
    ROM.env.relations(rel)
  end
end
