class AppIdentifiedUsersRelation < ROM::Relation[:sql]
  # gateway :default

  dataset :app_identified_users

  register_as :app_identified_users

  def find_user(app_id, userId)
    where(app_id: app_id, userId: userId).one
  end

  def find_by_handle(app_id, handle)
    where(app_id: app_id, handle: handle).as(:app_identified_user).one
  end

  # define your methods here ie:
  #
  # def all
  #   select(:id, :name).order(:id)
  # end
end
