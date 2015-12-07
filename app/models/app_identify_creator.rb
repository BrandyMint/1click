class AppIdentifyCreator
  def self.create(app_id:, userId:, visitorId:, sessionId:)
    new(app_id: app_id, userId: userId, visitorId: visitorId, sessionId: sessionId)
      .create
  end

  def initialize(app_id:, userId: ,visitorId:, sessionId:)
    @app_id = app_id
    @userId = userId
    @visitorId = visitorId
    @sessionId = sessionId
  end

  def create
  end

  private

  attr_reader :app_id, :userId, :visitorId, :sessionId
end
