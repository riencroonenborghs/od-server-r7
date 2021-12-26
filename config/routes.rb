Rails.application.routes.draw do  
  devise_for :users

  devise_scope :user do    
    resources :downloads, only: [:index, :new, :create, :destroy] do
      collection do
        get :queued
        get :started
        get :finished
        get :failed
        get :cancelled
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "downloads#queued"
end
