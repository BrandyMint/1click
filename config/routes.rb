require 'app_constraint'

Rails.application.routes.draw do
  get :a, controller: :receiver, action: :create

  root controller: :welcome, action: :index

  post :form, controller: :welcome

  delete :reset, controller: :welcome, action: :reset

  resource :snippet, controller: :snippet
  resources :apps, only: [:index, :show] do
    member do
      get :switch
    end
  end

  # scope constraints: AppConstraint do
  resources :app_events,        only: [:index]
  resources :app_users,         only: [:index, :show]
  resources :app_user_sessions, only: [:index, :show]
  resources :app_user_visits,   only: [:index, :show]
  resources :app_page_events,   only: [:index]

  resources :event_definitions
  # end
end
