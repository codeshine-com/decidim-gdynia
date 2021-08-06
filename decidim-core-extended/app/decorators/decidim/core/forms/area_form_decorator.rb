# frozen_string_literal: true

Decidim::Admin::AreaForm.class_eval do
  include Decidim::HasUploadValidations

  attribute :icon
  attribute :remove_icon
end
