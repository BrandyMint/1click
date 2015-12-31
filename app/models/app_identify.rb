class AppIdentify
  include ROM::Model::Attributes

  attribute :app_id,    Integer
  attribute :email,     String
  attribute :handle,    String
  attribute :sessionId, Integer
  attribute :visitId,   Integer
  attribute :userId,    Integer  # Текущий идентификатор пользователя, скорее всего аноним, который изменится
  attribute :data,      Sequel::Postgres::HStore

  timestamps
end
