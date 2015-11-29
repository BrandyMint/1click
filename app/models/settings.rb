class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env
  suppress_errors Rails.env.production?

  def tld_length
    default_url_options.host.split('.').count - 1
  end
end
