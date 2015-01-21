Rails.application.routes.draw do

  root to: "static_pages#index"

  get "/menu" => "items#index"

end
