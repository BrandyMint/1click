module ApplicationHelper
  def support_phone
    '8 (800) 77-55-661'
  end

  def tel_to(phone)
    link_to phone, "tel:#{phone}"
  end

  def paginate objects, options = {}
    options.reverse_merge!( theme: 'twitter-bootstrap-3', pagination_class: "pagination-small pagination-centered" )

    super( objects, options )
  end

  def event_types_collection
    [['Клик', 'click'], ['Форма', 'submit']]
  end

  def app_title
    buffer = '1ClickAnalytics'

    buffer << ":#{current_app}" if current_app.present?
    buffer
  end

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
