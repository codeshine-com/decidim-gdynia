# frozen_string_literal: true

Decidim::Forms::Questionnaire.class_eval do

  delegate :organization, to: :questionnaire_for, allow_nil: true

  def can_add_metrics?
    !(questions.find_by(metrics: Decidim::Forms::Question.const_get(:METRICS)[0]) &&
      questions.find_by(metrics: Decidim::Forms::Question.const_get(:METRICS)[1]) &&
      questions.find_by(metrics: Decidim::Forms::Question.const_get(:METRICS)[2])
    )
  end

  def has_no_metrics?(metrics)
    !questions.find_by(metrics: metrics)
  end
end
