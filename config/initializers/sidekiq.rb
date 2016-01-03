require 'sidekiq'
CONFIG_FILE = './config/crontab.yml'

if Rails.env.production?
  Sidekiq.configure_server do |config|
    # Sidekiq::Logging.logger = LoggerCreator.build :sidekiq
    # config.redis = Secrets.sidekiq.redis.symbolize_keys
    config.error_handlers << proc { |ex, context| Bugsnag.notify(ex, context) }
    config.failures_max_count = 50
    config.failures_default_mode = :exhausted
    # Sidekiq::Cron::Job.load_from_hash YAML.load_file(CONFIG_FILE)
  end

  Sidekiq.configure_client do |config|
    # config.redis = Secrets.sidekiq.redis.symbolize_keys
  end
else
  require 'sidekiq/testing/inline'
  Sidekiq::Testing.inline!
end

Sidekiq.default_worker_options = { 'backtrace' => true }
