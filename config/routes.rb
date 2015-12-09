require 'app_constraint'
require 'root_constraint'

Rails.application.routes.draw do
  default_url_options Settings.default_url_options.symbolize_keys

  scope subdomain: 'api', constraints: { subdomain: 'api' } do
    mount API => '/', as: :api
    root controller: :swagger, action: :index, as: :api_doc
  end

  resource :snippet, controller: :snippet
  post :form, controller: :welcome
  get :a, controller: :receiver, action: :create

  scope constraints: RootConstraint do

    get :login, controller: :sessions, action: :new
    post :login, controller: :sessions, action: :create

    root controller: :welcome, action: :index

    delete :reset, controller: :welcome, action: :reset

    resources :requests, only: [:index, :create]
    resources :apps, only: [:index, :show] do
      member do
        get :switch
      end
    end
  end

  scope module: :app, constraints: AppConstraint do
    root controller: :dashboard, action: :index, as: :dashboard
    resources :app_pages
    resources :app_hosts
    resources :app_events,        only: [:index]
    resources :app_users,         only: [:index, :show]
    resources :app_user_sessions, only: [:index, :show]
    resources :app_user_visits,   only: [:index, :show]
    resources :app_page_events,   only: [:index]

    resources :event_definitions
    resources :app_funnels
    resources :app_funnel_event_definitions
  end
end
