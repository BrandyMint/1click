module SnippetHelper
  def snippet_toggle_button
    if snippet_on?
      link_to 'Отключить сниппет', snippet_path, method: :delete, class: 'btn btn-sm btn-success'
    else
      link_to 'Включить сниппет', snippet_path, method: :create, class: 'btn btn-sm btn-warning'
    end
  end

  def include_snippet
    return unless  snippet_on?
    render 'snippet', app_id: 1, src: snippet_src, requestUrl: snippet_request_url
  end

  def snippet_on?
    session[:snippet]
  end

  def snippet_on!
    session[:snippet] = true
  end

  def snippet_off!
    session[:snippet] = false
  end

  def snippet_request_url
    if Rails.env.production?
      'http://cdn.1clickanalytics.ru/a.gif'
    else
      root_url + 'a.png'
    end
  end

  def snippet_src
    if Rails.env.production?
      'http://1clickanalytics.ru/widget.js'
    else
      '/widget.js'
    end
    # "https://rawgit.com/BrandyMint/aristotel/master/dist/art.js"
  end

  def insert_snippet
    if snippet_on?
      content_tag :div, 'Сниппет включен', class: 'text-success'
    else
      content_tag :div, 'Сниппет отключен', class: 'text-muted'
    end
  end
end
