# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :avatar do
      process :resize_to_fill => [960, 960]
  end

  version :post do
      process :resize_to_fill => [480, 480]
  end
end
