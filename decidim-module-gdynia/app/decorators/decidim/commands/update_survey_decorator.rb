# frozen_string_literal: true

Decidim::Surveys::Admin::UpdateSurvey.class_eval do
  private

  def update_survey_attributes
    @survey.update!(
      allow_answers: @form.allow_answers,
      allow_editing_answers: @form.allow_editing_answers,
      allow_unregistered: @form.allow_unregistered,
      starts_at: @form.starts_at,
      ends_at: @form.ends_at,
      clean_after_publish: @form.clean_after_publish,
      announcement: @form.announcement
    )

    if @survey.respond_to?(:visible_for_unregistered)
      @survey.update!(visible_for_unregistered: @form.visible_for_unregistered)
    end
  end
end
