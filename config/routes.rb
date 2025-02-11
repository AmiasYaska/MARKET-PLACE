Rails.application.routes.draw do
  resources :products do
    collection do
      get :my_products
    end

    get :autocomplete, on: :collection
    get :search, on: :collection
  end
  resource :profile, only: [:edit, :update]
  resources :purchases, only: [ :create ]

  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  authenticated :user do
    root "products#index", as: :authenticated_root
  end

  unauthenticated :user do
    root "pages#index"
  end
  # Defines the root path route ("/")
end
