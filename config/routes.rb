Rails.application.routes.draw do
  get "/ping", to: proc { [200, {}, ["pong"]] }

  # garde ça après :
  root "home#index"
end
