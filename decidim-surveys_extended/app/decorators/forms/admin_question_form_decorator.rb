# frozen_string_literal: true

Decidim::Forms::Admin::QuestionForm.class_eval do
  # include ActiveModel::Validations::Callbacks
  include Decidim::HasUploadValidations

  METRICS = %w(gender age district).freeze

  attribute :metrics, String
  attribute :question_image
  attribute :remove_question_image, Decidim::AttributeObject::TypeMap::Boolean

  # validates :question_image, passthru: { to: Decidim::Forms::Question }

  def metrics?
    METRICS.include? metrics
  end

  private

  def gender?
    metrics == 'gender'
  end

  def age?
    metrics == 'age'
  end

  def district?
    metrics == 'district'
  end
end
