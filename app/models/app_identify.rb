class AppIdentify
  include ROM::Model::Attributes

  attribute :app_id,    Integer
  attribute :email,     String
  attribute :handle,    String
  attribute :sessionId, Integer
  attribute :visitId,   Integer
  attribute :userId,    Integer

  timestamps
end
