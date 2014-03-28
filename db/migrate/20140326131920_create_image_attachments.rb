class CreateImageAttachments < ActiveRecord::Migration
  def change
    create_table :image_attachments do |t|
      t.integer :article_id
      t.integer :game_id
      t.string :image

      t.timestamps
    end
  end
end
