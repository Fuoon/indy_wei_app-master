class Article < ActiveRecord::Base
	belongs_to :user
	has_many :article_comments
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :title, presence: true, length: { maximum: 100}
	validates :content, presence: true
	has_many :image_attachments, dependent: :destroy
    accepts_nested_attributes_for :image_attachments

	def self.search(search)
	  if search
	    find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
	  else
	    find(:all)
	  end
	end
end
