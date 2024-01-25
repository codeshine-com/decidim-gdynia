# frozen_string_literal: true

Decidim::Admin::UploaderImageDimensionsHelper.class_eval do
  def image_dimensions(model, image_name)
    uploader = model.attached_uploader(image_name) || model.send(image_name)
    versions = uploader.dimensions_info
    [:small, :medium, :square, :mini_square, :default].map { |v| versions.dig(v, :dimensions) }.compact.first
  end
end
