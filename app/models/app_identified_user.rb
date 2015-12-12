class AppIdentifiedUser
  include ROM::Model::Attributes

  attribute :app_id, Integer
  attribute :userId, Integer
  attribute :handle, String
  attribute :email,  String
  attribute :data,   Sequel::Postgres::HStore

  timestamps
end
