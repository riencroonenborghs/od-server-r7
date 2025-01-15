require 'sidekiq/web'

Rails.application.routes.draw do  
  mount Sidekiq::Web => '/sidekiq'

  resources :downloads, only: [:index, :new, :create, :destroy] do
    collection do
      get :queued        
      get :started
      get :finished
      get :failed
      get :cancelled
      delete :remove_all_fininshed
    end
    member do
      post :queue
    end
  end

  resources :searches, only: [:index, :new, :create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "downloads#new"
end
