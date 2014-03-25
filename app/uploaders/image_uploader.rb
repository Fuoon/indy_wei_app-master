# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  process :resize_to_fit => [800, 800]

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
      ActionController::Base.helpers.asset_path("assets/" + [version_name, "article-default.png"].compact.join('_'))
  #
  #    "/images/fallback/" + ["default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process :scale => [1280, 480]
  #
  # def scale(width, height)
  #   # do something
  # end

  # process :resize_to_fit => [1280, 480]

  # Create different versions of your uploaded files:

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
