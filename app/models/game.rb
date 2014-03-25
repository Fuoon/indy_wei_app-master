class Game < ActiveRecord::Base
	has_many :relationships
	has_many :followers, :through => :relationships, :source => :user
	has_many :game_comments, dependent: :destroy
	belongs_to :user
	has_one :category
	has_one :status
	validates :user_id, presence: true
	validates :category_id, presence: true
	validates :status_id, presence: true
	validates :name, presence: true, length: { maximum: 50}
	validates :link, presence: true
	validates :description, presence: true
	mount_uploader :image, ImageUploader
	acts_as_votable

	def self.search(search)
	  if search
	    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	  else
	    find(:all)
	  end
	end
end
