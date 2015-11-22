Rails.application.routes.draw do
  root controller: :welcome, action: :index

  post :form, controller: :welcome

  resources :apps, only: [:index, :show]
  resources :app_events, only: [:index]
  resources :app_users, only: [:index, :show]
  resources :app_user_sessions, only: [:index, :show]
  resources :app_user_visits, only: [:index, :show]
  resources :app_page_events, only: [:index]

  delete :reset, controller: :welcome, action: :reset

  resource :snippet, controller: :snippet

  get :a, controller: :receiver, action: :create
end
