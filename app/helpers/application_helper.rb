module ApplicationHelper

  def humanized_dom_path(dom_path)
    dom_path.map do |e|
      e.tr(';', '')
    end.join ' '
  end

  def page_event_label(page_event)
    case page_event.event_type
    when 'click'
      content_tag :span, page_event.event_name, class: 'label label-success'
    when 'submit'
      content_tag :span, page_event.event_name, class: 'label label-primary'
    else
      content_tag :span, page_event.event_name, class: 'label label-warning'
    end
  end

  # localtime
  def lt(time)
    time = time.created_at if time.respond_to?(:created_at)
    l time, format: :normal
  end
end