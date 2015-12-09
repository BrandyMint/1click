class AppIdentifiedUser
  include ROM::Model::Attributes

  attribute :app_id, Integer
  attribute :userId, Integer
  attribute :handle, String
  attribute :email,  String

  timestamps

end
