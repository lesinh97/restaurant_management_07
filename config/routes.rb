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
  resources :booking_tickets
  get "/auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")
  get "login_google", to: redirect("/auth/google_oauth2"), as: "login_google"
  get "login_facebook", to: redirect("/auth/facebook"), as: "login_facebook"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
