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
  post "/invite/:id", to: "servers#invite" # Again, might make an invite code system instead

  get "/server/:server_id/channels", to: "channels#index"
  get "/server/:server_id/channel/:channel_id", to: "channels#show"
  post "/server/:server_id/channels/new", to: "channels#create"
  patch "/channel/:id/edit", to: "channels#update"
  delete "/channel/:id", to: "channels#destroy"

  get "/channel/:channel_id/messages", to: "messages#index"
  post "/channel/:channel_id/messages/new", to: "messages#create"
  patch "/message/:id/edit", to: "messages#edit"
  delete "/message/:id", to: "messages#destroy"
end
