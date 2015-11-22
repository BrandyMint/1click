module SnippetHelper
  def snippet_toggle_button
    if snippet_on?
      link_to 'Отключить сниппет', snippet_path, method: :delete, class: 'btn btn-sm btn-success'
    else
      link_to 'Включить сниппет', snippet_path, method: :create, class: 'btn btn-sm btn-warning'
    end
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

  def insert_snippet
    if snippet_on?
      buffer = render 'snippet', app_id: 1, src: "https://rawgit.com/BrandyMint/aristotel/master/dist/art.js"
      buffer << 'Сниппет включен'
      return buffer
    else
      return content_tag :div, 'Сниппет отключен', class: 'text-muted'
    end
  end
end
