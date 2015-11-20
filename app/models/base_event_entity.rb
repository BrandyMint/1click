class BaseEventEntity
  include Virtus.model
  TYPES = {
    '0' => 'Новый пользователь',
    '1' => 'Новая сессия',
    '2' => 'Новый визит',
    'click' => 'Клик',
    'submit' => 'Отправка формы'
  }

  BASE_SHORTS = {
    tm: :time,
    a:  :appId,
    u:  :userId,
    s:  :sessionId,
    v:  :visitId,
    m:  :source, # web
  }

  BASE_SHORTS.values.each { |v| attribute v }

  def self.build(params)
    new params.slice( *BASE_SHORTS.keys )
  end

  def timestamp
    Time.at time.to_i / 1000
  end

  def to_s
    buffer = type_name.dup
    buffer << " (неполный)" unless complete?
    buffer
  end

  def complete?
    type.present? &&
      appId.present? &&
      userId.present? && sessionId.present? && visitId.present? &&
      source.present?
  end

  def type_name
    TYPES[type] || "Неизвестный тип (#{type})"
  end
end
