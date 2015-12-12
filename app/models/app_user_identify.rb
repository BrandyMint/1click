class AppUserIdentify
  include ROM::Model::Attributes

  attribute :app_id,    Integer
  attribute :visitUserId,     String
  attribute :handledUserId,    String

  timestamps
end
