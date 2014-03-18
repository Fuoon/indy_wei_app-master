class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :link
      t.string :description
      t.integer :category_id
      t.integer :user_id
      t.integer :status_id

      t.timestamps
    end
    add_index :games, [:user_id, :created_at]
  end
end
