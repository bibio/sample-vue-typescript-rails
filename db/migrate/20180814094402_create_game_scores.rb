class CreateGameScores < ActiveRecord::Migration[5.2]
  def change
    create_table :game_scores do |t|
      t.string :player_name
      t.integer :score

      t.timestamps
    end
  end
end
