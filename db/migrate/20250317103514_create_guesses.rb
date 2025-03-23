class CreateGuesses < ActiveRecord::Migration[8.0]
  def change
    create_table :guesses do |t|
      t.integer :user_id
      t.integer :image_id
      t.string :guessed_country
      t.boolean :correct

      t.timestamps
    end
  end
end
