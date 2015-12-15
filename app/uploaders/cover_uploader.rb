# encoding: utf-8

class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # storage :file
  # storage :box
  storage :dropbox
  process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fill: [200,200]
  end
  version :preview do
    process resize_to_fill: [50,50]
  end
  def store_dir
    "uploads/#{model.class.to_s.underscore}/"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
