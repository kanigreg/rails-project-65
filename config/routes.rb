# frozen_string_literal: true

Rails.application.routes.draw do
  root 'web/bulletins#index'

  scope module: :web do
    resources :bulletins

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'

    namespace :admin do
      get '/', to: 'dashboard#index', as: :dashboard
      resources :bulletins
      resources :categories
      resources :users
    end
  end
end
