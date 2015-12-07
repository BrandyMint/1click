class AppsRelation < ROM::Relation[:sql]
  # gateway :default

  dataset :apps

  register_as :apps

  delegate :count, to: :dataset

  # define your methods here ie:
  #
  def all
    order(:id)
  end
end
