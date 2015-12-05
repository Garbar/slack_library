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
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


end
