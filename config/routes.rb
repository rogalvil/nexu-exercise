# frozen_string_literal: true

# Routes
Rails.application.routes.draw do
  resources :brands, only: %i[index create] do
    resources :models, only: %i[index create], controller: :car_models
  end

  resources :models, only: %i[index update], controller: :car_models

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ('/')
  # root 'posts#index'
end
