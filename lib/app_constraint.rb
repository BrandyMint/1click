class AppConstraint
  def self.matches?(request)
    request.session[:init] = true
    app_id = request.session['app_id']

    return false unless app_id.present?

    app = App.find_by_id app_id
    if app.present?
      Thread.current[:app] = app
    else
      Thread.current[:app] = nil
    end
  end
end
