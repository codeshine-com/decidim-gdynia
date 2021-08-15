# frozen_string_literal: true

Decidim::Forms::Admin::QuestionForm.class_eval do
  # include ActiveModel::Validations::Callbacks

  METRICS = %w(gender age district).freeze

  attribute :metrics, String

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
