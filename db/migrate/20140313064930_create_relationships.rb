class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :game_id
    add_index :relationships, [:user_id, :game_id], unique: true
  end
end
