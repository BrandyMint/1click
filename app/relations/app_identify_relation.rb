class AppIdentifyRelation < ROM::Relation[:sql]
  dataset :app_identifies

  register_as :app_identifies

  # define your methods here ie:
  #
  def all
    select(:id, :name).order(:id)
  end
end
