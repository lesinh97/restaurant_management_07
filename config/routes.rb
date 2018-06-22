Rails.application.routes.draw do
  root "static_pages#index"
  get "/signup", to: "customers#new"
  post "/signup", to: "customers#create"
  resources :customers
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: :edit
  resources :rooms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
