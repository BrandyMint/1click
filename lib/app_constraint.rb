class AppConstraint
  APP_PREFIX = 'app-'

  def self.matches?(request)
    return false unless request.subdomain.start_with? APP_PREFIX
    app_id = request.subdomain.to_s.sub APP_PREFIX, ''

    return false unless app_id.present?

    app = AppRepository.new(ROM.env).find app_id
    if app.present?
      Thread.current[:app] = app
    else
      Thread.current[:app] = nil
    end
  end
end
