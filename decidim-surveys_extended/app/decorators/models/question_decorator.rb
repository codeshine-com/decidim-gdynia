# frozen_string_literal: true

Decidim::Forms::Question.class_eval do
  METRICS = %w(gender age district).freeze

  after_create :set_metrics_answers, if: :metrics?

  def set_metrics_answers
    if gender?
      Decidim::User.const_get(:GENDERS).each do |g|
        answer_options.new(body: { pl: I18n.t("activemodel.attributes.user.gender.#{g}") })
      end
    elsif age?
      Decidim::User.const_get(:AGE).each do |g|
        answer_options.new(body: { pl: I18n.t("activemodel.attributes.user.age.#{g}") })
      end
    elsif district?
      Decidim::Scope.where(organization: organization).where(promoted: false).each do |scope|
        answer_options.new(body: scope.name )
      end
      answer_options.new(body: { pl: I18n.t("activemodel.attributes.question.scope_no_answer") } )
    end
    self.save
  end

  def metrics?
    METRICS.include? metrics
  end

  def gender?
    metrics == 'gender'
  end

  def age?
    metrics == 'age'
  end

  def district?
    metrics == 'district'
  end

  def organization
    questionnaire&.questionnaire_for&.organization
  end
end
