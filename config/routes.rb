Rails.application.routes.draw do
  devise_for :artists, controllers: {
    registrations: 'artists/registrations',
    sessions: 'artists/sessions',
    passwords: 'artists/passwords'
   }
  
  # routes for artists and nested arts 
  resources :artists, only: [:index, :show, :edit, :update, :destroy] do
    resources :arts, only: [:index, :show, :edit, :update, :destroy, :new, :create]
  end

  # route to allow searching and download count all arts independent of the artist
  resources :arts, only: [] do
    collection do
      get :search
    end
    member do
      get :download_image
      get :download_image_with_resolution
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "artists#index"
end
