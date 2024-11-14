Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "posts#index"

  get "/servers", to: "servers#index"
  get "/server/:id", to: "servers#show"
  post "/servers/create", to: "servers#create"
  patch "/server/:id/edit", to: "servers#edit"
  delete "/server/:id", to: "servers#destroy"
end
