class AppIdentifyCreator
  include DBTables

  def self.create(identify)
    new(identify).create
  end

  def initialize(identify)
    @identify = identify
  end

  def create
    log_identify(identify)
    find_identified_user_id || create_identified_user_id
  end

  private

  attr_reader :identify

  delegate :handle, :app_id, :userId, to: :identify

  def log_identify(identify)
    app_identifies.insert identify.to_h
  end

  def find_identified_user_id
    iu = app_identified_users
      .select(:userId)
      .where(handle: handle, app_id: app_id)
      .first

    return unless iu
    merge_user_data identify.data if identify.data.present?
    log_user_identify iu[:userId]
    iu[:userId]
  end

  def merge_user_data(data)
    app_identified_users
      .where(app_id: app_id, handle: handle)
      .update(data: Sequel.hstore_op(:data).concat(data))
  end

  def log_user_identify handledUserId
    user_identify = AppUserIdentify.new(app_id: app_id, visitUserId: identify.userId, handledUserId: handledUserId)
    app_user_identifies.insert user_identify.to_h
  end

  def create_identified_user_id
    identified_user = AppIdentifiedUser.new identify

    app_identified_users
      .insert identified_user.to_h

    identify.userId
  end
end
