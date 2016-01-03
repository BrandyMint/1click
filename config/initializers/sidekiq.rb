require 'sidekiq'

unless Rails.env.production?
  require 'sidekiq/testing/inline'
  Sidekiq::Testing.inline!
end

Sidekiq.default_worker_options = { 'backtrace' => true }
