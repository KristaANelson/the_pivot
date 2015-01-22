Rails.application.routes.draw do

  root to: "static_pages#index"

  get "/menu" => "items#index"

  get "/cart" => "cart_items#index"

  post "/cart" => "cart_items#create"
end
