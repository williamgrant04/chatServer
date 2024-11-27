Rails.application.routes.draw do
  devise_for :users, path: "",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup"
    },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }

  devise_scope :user do
    get "/loggedin", to: "users/sessions#logged_in?"
  end

  get "/servers", to: "servers#index"
  get "/server/:id", to: "servers#show"
  post "/servers/new", to: "servers#create"
  patch "/server/:id/edit", to: "servers#update"
  delete "/server/:id", to: "servers#destroy"

  get "/server/:server_id/channels", to: "channels#index"
  get "/channel/:id", to: "channels#show"
  post "/server/:server_id/channels/new", to: "channels#create"
  patch "/channel/:id/edit", to: "channels#update"
  delete "/channel/:id", to: "channels#destroy"
end
