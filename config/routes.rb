Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  get "/", to: "home#index"
  resources :menus
  resources :menuitems
  resources :orders
  resources :orderitems
  get "/signin" , to:"sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to:"sessions#destroy", as: :destroy_session
end
