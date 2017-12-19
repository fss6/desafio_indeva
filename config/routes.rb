Rails.application.routes.draw do
  get 'home', to: 'home#index'
  root to: "home#index"

  devise_for :owners, only: [:sessions, :registrations]

  resources :sellers, except: [:show]
  resources :stores, except: [:show]
end
