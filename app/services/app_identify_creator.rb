class AppIdentifyCreator
  def self.create(identify)
    identified_user = AppIdentifiedUsersRepository
      .new(ROM.env)
      .find_or_create(identify)

    identify = ROM.env
      .command(:app_identifies)
      .as(:app_identify)
      .create
      .call identify

    identified_user.userId
  end

  def initialize(identify)
    @identify = identify
  end

  def create
    find_identified_user_id || create_identified_user_id
    identified_user
  end

  private

  attr_reader :identify

  delegate :handle, :app_id, to: :identify

  def save_identify
    db[:app_identifies].insert identify.to_h
  end

  def identified_user
    AppIdentifiedUser.new identify
  end

  def find_identified_user_id
    db[:app_identified_users].select(:userId).where(handle: handle, app_id: app_id).first[:userId]
  end

  def create_identified_user_id
    db[:app_identified_users].insert identified_user.to_h
    identify.userId
  end

  def db
    ROM.env.gateways[:default].connection
  end
end
