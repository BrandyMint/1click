class AppIdentifiedUser
  include ROM::Model::Attributes

  attribute :app_id, Integer
  attribute :userId, Integer
  attribute :handle, String

  timestamps
end
