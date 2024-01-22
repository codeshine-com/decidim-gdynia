# frozen_string_literal: true

Decidim::Forms::Question.class_eval do
  METRICS = %w(gender age district).freeze

  after_create :set_metrics_answers, if: :metrics?

  delegate :organization, to: :questionnaire, allow_nil: true

  #  TODO: do akutalizacjia uploader
  # mount_uploader :question_image, Decidim::ImageUploader

  def set_metrics_answers
    if gender?
      Decidim::User.const_get(:GENDERS).each do |g|
        answer_options.new(body: { pl: I18n.t("activemodel.attributes.user.genders.#{g}") })
      end
    elsif age?
      Decidim::User.const_get(:AGE).each do |g|
        answer_options.new(body: { pl: I18n.t("activemodel.attributes.user.ages.#{g}") })
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
end
