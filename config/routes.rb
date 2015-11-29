require 'app_constraint'

Rails.application.routes.draw do

  get :a, controller: :receiver, action: :create

  root controller: :welcome, action: :index

  post :form, controller: :welcome

  delete :reset, controller: :welcome, action: :reset

  resources :requests, only: [:index, :create]
  resource :snippet, controller: :snippet
  resources :apps, only: [:index, :show] do
    member do
      get :switch
    end
  end

  scope constraints: AppConstraint do
    get :dashboard, controller: :dashboard, action: :index
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
