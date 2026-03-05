# frozen_string_literal: true

Decidim::Forms::Question.class_eval do
  # delegate :organization, to: :questionnaire, allow_nil: true

  # mount_uploader :question_image, Decidim::Cw::ImageUploader
  has_one_attached :question_image
end
