Rails.application.routes.draw do
  root "home#index"  # Page d'accueil

  devise_for :users  # 🔥 Génère toutes les routes d'authentification

  get "game", to: "game#index"
  post "guess", to: "game#guess"
  get "next_image", to: "game#next_image"

  get "ranking", to: "game#ranking"
end
