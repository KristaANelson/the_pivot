Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :users, only: [:new, :create]

  get "/login"  => "sessions#new"
  post "/login"  => "sessions#create"
  delete "/logout" => "sessions#destroy"

  post "/users" => "users#create"

  get "/menu" => "items#index"

  get "/admin" => "admin#index"

  get "/cart" => "cart_items#index"
  post "/cart" => "cart_items#create"
  post "/remove_item" => "cart_items#destroy"
  post "/update_item" => "cart_items#update"

  patch "/categories/:id" => "categories#update"
  resources :categories, only: [:create, :edit, :destroy, :new, :index]

end
