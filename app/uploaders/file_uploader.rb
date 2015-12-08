# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :dropbox
  # include CarrierWave::MagicMimeTypes

  # process :set_content_type
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(txt doc docx epub pdf mobi fb2)
  end
  process :save_content_type_and_size_in_model

  def save_content_type_and_size_in_model
    model.format = file.content_type if file.content_type

  end
end
