Rails.application.routes.draw do
  get 'home', to: 'home#index'
  root to: "home#index"
end
