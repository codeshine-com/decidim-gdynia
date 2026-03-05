# frozen_string_literal: true

Decidim::Forms::Admin::QuestionForm.class_eval do
  # include ActiveModel::Validations::Callbacks
  include Decidim::HasUploadValidations

  attribute :question_image
  attribute :remove_question_image, Decidim::AttributeObject::TypeMap::Boolean

  # validates :question_image, passthru: { to: Decidim::Forms::Question }
end
