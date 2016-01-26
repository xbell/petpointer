Rails.application.routes.draw do
  root to: "petter#index"

  get  "/sign-up"             , to: "users#sign_up"
  post "/users"               , to: "users#create" , as: :create_user

  get "/map", to: "map#index"

  get "/yelp", to: "yelp_test#yelp"

end
