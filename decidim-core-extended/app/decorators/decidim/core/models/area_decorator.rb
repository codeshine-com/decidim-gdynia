# frozen_string_literal: true

Decidim::Area.class_eval do
  include Decidim::HasUploadValidations

  # mount_uploader :icon, Decidim::Cw::ImageUploader
  has_one_attached :icon
  validates_upload :icon, uploader: Decidim::ImageUploader

  # Return square: { resize_to_fit: [40, 40] } from uploader
  def icon_square
    icon.variant(resize_to_fit: [60, 60])
  end

  # Return mini_square: { resize_to_fit: [40, 40] } from uploader
  def icon_mini_square
    icon.variant(resize_to_fit: [40, 40])
  end
end
