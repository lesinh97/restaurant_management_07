Rails.application.routes.draw do
  get 'admins/index'

  root "static_pages#index"

  get "/signup", to: "customers#new"
  post "/signup", to: "customers#create"

  resources :customers, except: :destroy

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :account_activations, only: :edit
  resources :rooms, only: %i(index show)

  resources :booking_tickets do
    member do
      patch :change_status
      patch :cancel
      put :change_status
      put :cancel
    end
  end

  get "/auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")
  get "login_google", to: redirect("/auth/google_oauth2"), as: "login_google"
  get "login_facebook", to: redirect("/auth/facebook"), as: "login_facebook"

  get "/statistics", to: "admins#index"

  namespace :admin do
    resources :rooms, except: %i(index show)
    resources :rooms do
      member do
        patch :change_status
        put :change_status
      end
    end
    resources :customers, only: %i(destroy index)
  end

  resources :invoices
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
