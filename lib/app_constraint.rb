class AppConstraint
  APP_PREFIX = 'app-'

  def self.matches?(request)
    app_id = request.subdomain.to_s.sub APP_PREFIX, ''

    return false unless app_id.present?

    app = App.find_by_id app_id
    if app.present?
      Thread.current[:app] = app
    else
      Thread.current[:app] = nil
    end
  end
end
