Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :users, only: [:new, :create]

  get "/login"  => "sessions#new"
  post "/login"  => "sessions#create"
  delete "/logout" => "sessions#destroy"
  get "/login_for_cart" => "sessions#new"
  get "/checkout_after_login" => "session#checkout"
  get "/menu" => "items#menu"

  get "/admin" => "admin#index"


  get "/cart" => "cart_items#index"
  post "/cart" => "cart_items#create"
  post "/remove_item" => "cart_items#destroy"
  post "/update_item" => "cart_items#update"

  resources :items, only: [:show]
  resources :orders, only: [:show, :new, :create, :index]

  scope "admin", module: "admin" do
    post "/orders/:status" => "orders#filter", as: "admin_filter_order"
    get "/orders/:status" => "orders#filter", as: "admin_order"
    patch "/categories/:id" => "categories#update"
    resources :categories, only: [:create, :edit, :destroy, :new, :index]
    resources :items, only: [:index, :new, :create]
  end

  get "*rest" => "static_pages#not_found"
end
