class CreateGameComments < ActiveRecord::Migration
  def change
    create_table :game_comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end
