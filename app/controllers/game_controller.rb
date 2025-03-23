class GameController < ApplicationController
  def index
    @image = next_unique_image
  end

  def guess
    image = Image.find(params[:image_id])
    guessed_country = params[:guessed_country]&.strip&.downcase

    if guessed_country.blank?
      render json: { message: "⏳ Temps écoulé ! Vous avez perdu.", correct: false }
      return
    end

    correct = image.country.downcase == guessed_country

    if correct
      current_user.update(score: (current_user.score || 0) + 10)
      message = "Bonne réponse ! 🎉 +10 points"
    else
      message = "Mauvaise réponse, réessaye avant la fin du temps !"
    end

    render json: { message: message, correct: correct, score: current_user.score }
  end

  def ranking
    @players = User.order(score: :desc).limit(10)  # 🔥 Classement des 10 meilleurs joueurs
  end

  def next_image
    if session[:seen_images].size >= Image.count
      render json: { finished: true } # 🔥 Indique que le jeu est terminé
    else
      @image = next_unique_image
      render json: { finished: false, html: render_to_string(partial: "game/game_content", locals: { image: @image }) }
    end
  end

  private

  # Fonction pour récupérer une nouvelle image non répétée
  def next_unique_image
    session[:seen_images] ||= []  # Initialise la session si vide
    available_images = Image.where.not(id: session[:seen_images])  # Récupère les images non encore vues

    if available_images.empty?
      session[:seen_images] = []  # Réinitialise la liste si toutes les images ont été vues
      available_images = Image.all
    end

    new_image = available_images.sample  # Choisir une image aléatoire parmi celles restantes
    session[:seen_images] << new_image.id  # Ajouter l'image à la liste des images vues

    new_image
  end
end
