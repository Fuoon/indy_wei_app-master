class CreateArticleComments < ActiveRecord::Migration
  def change
    create_table :article_comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
    add_index :article_comments, [:user_id, :created_at]
  end
end
