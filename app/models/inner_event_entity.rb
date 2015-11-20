class InnerEventEntity < BaseEventEntity # PageEvent
  SHORTS = {
    t: :type, # slick, submit
    n: :element_tag,
    l: :classes,
    i: :element_id,
    f: :href,
    w: :dom,
    x: :inner_text
  }

  SHORTS.values.each { |v| attribute v }

  def self.build(params, suffix)
    e = new
    BASE_SHORTS.each do |short, long|
      e.send "#{long}=", params[short.to_s]
    end

    SHORTS.each do |short, long|
      e.send "#{long}=", params[short.to_s + suffix.to_s]
    end
    e
  end

  def element_classes
    classes.to_s.split(' ').compact
  end

  def dom_path
    dom.to_s.split('|').compact
  end

  def to_s
    buffer = super.dup
    buffer << " тег #{tag}"
    buffer << ".#{classes}" if classes.present?
    buffer << "##{id}" if id.present?
    buffer << ", с текстом #{text}" if text.present?
    buffer << ", href=#{href}" if href.present?
    buffer << ", dom=#{dom}" if dom.present?
    buffer
  end
end
