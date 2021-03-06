# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :post do
    resize_to_limit(360,360)
  end

  version :square do
    resize_to_fill(480,480)
  end

end
