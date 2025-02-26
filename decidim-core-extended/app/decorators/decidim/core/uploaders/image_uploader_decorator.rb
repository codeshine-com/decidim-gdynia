# frozen_string_literal: true

Decidim::ImageUploader.class_eval do
  set_variants do
    {
      square: { resize_to_fit: [60, 60] },
      mini_square: { resize_to_fit: [40, 40] }
    }
  end
end
