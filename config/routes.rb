Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
   root "items#index"

  authenticate :user do
    resources :users
    resources :warehouses do
      get :addresses,   on: :member
      get :information, on: :member
    end
    resources :addresses
    resources :items
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
  end
end
