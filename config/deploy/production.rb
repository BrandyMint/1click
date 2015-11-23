set :application, 'oneclickanalytics.ru'
set :stage, :production
set :repo_url, 'git@github.com:BrandyMint/1click.git'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, -> { "/home/wwwoneclickanalytics/#{fetch(:application)}" }
server 'icfdev.ru', user: 'wwwoneclickanalytics', port: 255, roles: %w(web app db)
set :rails_env, :production
set :branch, ENV['BRANCH'] || 'master'
fetch(:default_env).merge!(rails_env: :production)
