class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :pseudo, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }

  # 🔥 Assurer que le score est toujours initialisé à 0
  after_initialize :set_default_score, if: :new_record?

  private

  def set_default_score
    self.score ||= 0
  end
end
