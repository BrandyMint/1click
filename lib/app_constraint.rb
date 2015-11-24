class AppConstraint
  def self.matches?(request)
    app_id = request.subdomain

    if app_id.starts_with?('app-')
      app_id = app_id.sub 'app-', ''
      app = App.find app_id

      if app.present?
        Thread.current[:app] = app
        return true
      else
        return false
      end
    end
  end
end
