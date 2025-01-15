require 'sidekiq/web'

Rails.application.routes.draw do  
  mount Sidekiq::Web => '/sidekiq'

  resources :downloads, only: [:index, :new, :create, :destroy] do
    collection do
      delete :remove_all_fininshed
    end
  end

  resources :queued_downloads, only: [:index, :create]
  resources :started_downloads, only: [:index]
  resources :finished_downloads, only: [:index]
  resources :failed_downloads, only: [:index]
  resources :cancelled_downloads, only: [:index]

  resources :searches, only: [:index, :new, :create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "downloads#new"
end
