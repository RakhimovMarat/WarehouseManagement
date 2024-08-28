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
      get :addresses,             on: :member
      get :information,           on: :member
      get :get_item,              on: :member
      patch :add_item_to_address, on: :member
    end
    resources :addresses
    resources :items do
      get :get_address,           on: :member
      patch :put_item_on_address, on: :member
    end
  end
end
