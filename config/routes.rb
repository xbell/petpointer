Rails.application.routes.draw do

  root to: "petter#index"

  get  "/sign-up"             , to: "users#sign_up", as: :sign_up
  post "/users"               , to: "users#create" , as: :create_user

  get '/sign-in', to: "sessions#new"
  post '/sign-in', to: "sessions#create"

  get "/map", to: "map#index"

  get  "/yelp"                , to: "yelp#yelp"
  get  "/yelp/search"         , to: "yelp#search"

end
