Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users

  get "/", to: "home#index"
  resources :menus
  resources :menu_items
  resources :orders
  resources :order_items
  post "/new_item", to: "menus#new_item", as: :new_item
  delete "/delete_item/:id", to: "menus#delete_item", as: :delete_item
  put "/update_item/:id", to: "menus#update_item", as: :update_item
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to: "sessions#destroy", as: :destroy_session
  get "/complete", to: "orders#complete", as: :complete_order
  resources :admin
  get "/view", to: "admin#view", as: :view_users
  get "/invoice/:id", to: "order_items#view", as: :view_invoice
  get "/update_user/:id", to: "update_user#index", as: :view_edit_user
  patch "/update_user/:id", to: "update_user#update", as: :update_user
end
