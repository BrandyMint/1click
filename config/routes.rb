Rails.application.routes.draw do
  root controller: :welcome, action: :index

  resources :apps, only: [:index, :show]
  resources :app_events, only: [:index]
  resources :app_inner_events, only: [:index]
  resources :app_sessions, only: [:index, :show]
  resources :app_users, only: [:index, :show]
  resources :app_visits, only: [:index]

  get :a, controller: :receiver, action: :create
end
