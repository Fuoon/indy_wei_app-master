class ImageAttachment < ActiveRecord::Base
	mount_uploader :image, ImageUploader
    belongs_to :game
    belongs_to :article
end
