# frozen_string_literal: true

Rails.application.routes.draw do
  root 'web/bulletins#index'

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'

    get 'profile', to: 'users#profile'

    resources :bulletins do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    namespace :admin do
      get '/', to: 'dashboard#index', as: :dashboard
      resources :bulletins do
        member do
          patch :publish
          patch :reject
        end
      end
      resources :categories
      resources :users
    end
  end
end
