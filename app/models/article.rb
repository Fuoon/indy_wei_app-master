class Article < ActiveRecord::Base
	belongs_to :user
	has_many :article_comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :title, presence: true, length: { maximum: 50}
	validates :content, presence: true
	mount_uploader :image, ImageUploader
end