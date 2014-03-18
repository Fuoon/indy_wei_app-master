class User < ActiveRecord::Base
    has_many :relationships
    has_many :articles
    has_many :games, :through => :relationships
    has_many :article_comments, dependent: :destroy
    has_many :game_comments, dependent: :destroy
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :username, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }
    mount_uploader :image, ImageUploader

    def User.new_remember_token
    	SecureRandom.urlsafe_base64
    end

    def User.hash(token)
    	Digest::SHA1.hexdigest(token.to_s)
    end

    def following?(game)
        relationships.find_by(game_id: game.id)
    end

    def follow!(game)
        relationships.create!(game_id: game.id)
    end

    def unfollow!(game)
        relationships.find_by(game_id: game.id).destroy
    end

    private

	    def create_remember_token
	    	self.remember_token = User.hash(User.new_remember_token)
	    end
end
