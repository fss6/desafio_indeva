Rails.application.routes.draw do
  devise_for :owners, only: [:sessions, :registrations]
  get 'home', to: 'home#index'
  root to: "home#index"
end
