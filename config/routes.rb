Rails.application.routes.draw do

  root to: "static_pages#index"

  get "/menu" => "items#index"

  get "/cart" => "cart_items#index"

  post "/cart" => "cart_items#create"

  post "/remove_item" => "cart_items#destroy"

  post "/update_item" => "cart_items#update"

  resources :categories, only: [:create, :edit, :destroy, :new]
end
