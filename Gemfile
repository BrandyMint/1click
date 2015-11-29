source 'https://rubygems.org'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

gem 'pg'

gem 'virtus'

gem 'bugsnag'
gem 'settingslogic'

gem 'upsert'

gem 'nprogress-rails'

gem 'sprockets-rails', github: 'rails/sprockets-rails', require: 'sprockets/railtie'

gem 'bootstrap', '~> 4.0.0.alpha1'
gem 'semver2'


gem 'cocoon'
gem 'simple-navigation', git: 'git://github.com/andi/simple-navigation.git'
gem 'simple-navigation-bootstrap'

gem 'font-awesome-rails'
gem 'simple_form', git: 'git://github.com/plataformatec/simple_form.git'

# gem 'nested_form'
# gem 'cocoon'

gem 'kaminari'
gem 'bootstrap-kaminari-views'

gem 'slim-rails'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use sqlite3 as the database for Active Record
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'active_link_to'
gem 'smsc'

#gem 'sidekiq-reset_statistics'
#gem 'sidekiq-failures', github: 'mhfs/sidekiq-failures'
#gem 'sidekiq-unique-jobs'
#gem 'sidekiq-status'
# gem 'sidekiq-statsd'
gem 'sidekiq'
#gem 'sidekiq-cron'

gem 'inherited_resources'
gem 'responders'
gem 'has_scope'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'byebug'
  gem 'bond'
  gem 'jist'
  gem 'pry-rails'
  gem 'pry-theme'

  gem 'pry-pretty-numeric'
  gem 'pry-highlight'

  gem 'pry-nav'
  gem 'pry-doc'
  gem 'pry-docmore'

  # Добавляет show-stack
  gem 'pry-stack_explorer'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'listen', '~> 3.0'
  gem 'guard', '> 2.12'

  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-minitest'
  gem 'guard-bundler'
  gem 'guard-ctags-bundler'
end


group :deploy do
  gem 'capistrano', '~> 3.1', require: false
  gem 'capistrano-rbenv', '~> 2.0',  require: false
  gem 'capistrano-rails', '~> 1.1.3', require: false
  gem 'capistrano-bundler', require: false

  # Используем planetio/capistrano-db-tasks
  # потому что у него есть dump_cmd_flags через который передается список таблиц для игнора
  #
  gem 'capistrano-db-tasks', require: false, github: 'planetio/capistrano-db-tasks'
end
