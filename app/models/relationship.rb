class Relationship < ActiveRecord::Base
	belongs_to :user
	belongs_to :game
	belongs_to :follower, :class_name => "User"
	belongs_to :following, :class_name => "Game"
	validates :user_id, presence: true
	validates :game_id, presence: true
end
