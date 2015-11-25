class AppPageEvent < ActiveRecord::Base
  def to_s
    "#{event_name} #{element} \"#{inner_text}\""
  end

  def element
    b = element_tag.dup
    b << "##{element_id}" if element_id.present?
    b << '.'+element_classes.join('.') if element_classes.present?
    b
  end

  def event_name
    case event_type
    when 'click'
      'Кликнул'
    when 'submit'
      'Форма'
    else
      event_type
    end
  end

  def dom
    dom_path.join('|')
  end
end
