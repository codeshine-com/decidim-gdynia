# frozen_string_literal: true

Decidim::ImageUploader.class_eval do

  version :square do
    process resize_to_fit: [60, 60]
  end
  version :mini_square do
    process resize_to_fit: [40, 40]
  end
end
