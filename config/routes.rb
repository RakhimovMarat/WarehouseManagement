# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'items#index'

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'

    resources :users

    resources :warehouses do
      get :addresses,   on: :member
      get :information, on: :member
    end

    resources :addresses do
      get :import_addresses, on: :collection
      post :import,          on: :collection
    end

    resources :items do
      get :import_items, on: :collection
      post :import,      on: :collection
    end

    resources :receipts do
      get :receipt_transactions, on: :collection
    end

    resources :expenses do
      get :expense_transactions, on: :collection
    end

    resources :relocates do
      get :relocate_transactions, on: :collection
    end

    resources :stocks

    resources :orders do
      patch :update_quantity,   on: :member
      patch :order_cancelation, on: :member
      get :get_order,           on: :member
    end
  end
end
