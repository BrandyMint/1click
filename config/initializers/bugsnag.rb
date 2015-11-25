Bugsnag.configure do |config|
  config.api_key = "0b9d07db082c99affe41bb4a7ef737ea"
  config.app_version = ClickVersion.format('%M.%m.%p')

  config.notify_release_stages = %w(production staging reproduction)
  config.send_code = true
  config.send_environment = true
end
