Rails.application.routes.draw do
  devise_for :artists, controllers: {
    registrations: 'artists/registrations',
    sessions: 'artists/sessions',
    passwords: 'artists/passwords'
   }
   
  resources :artists, only: [:index, :show, :edit, :update, :destroy] do
    resources :arts, only: [:index, :show, :edit, :update, :destroy, :new, :create]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "artists#index"
end
