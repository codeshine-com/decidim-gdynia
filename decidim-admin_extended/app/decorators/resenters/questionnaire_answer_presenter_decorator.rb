# frozen_string_literal: true

Decidim::Forms::Admin::QuestionnaireAnswerPresenter.class_eval do

  # overwritten, added matrix row body
  def body
    return answer.body if answer.body.present?
    return attachments if answer.attachments.any?
    return "-" if answer.choices.empty?

    choices = answer.choices.map do |choice|
      {
        row_body: choice.matrix_row.try(:body),
        answer_option_body: choice.try(:answer_option).try(:translated_body),
        choice_body: body_or_custom_body(choice)
      }
    end

    return choice(choices.first) if answer.question.question_type == "single_option"

    content_tag(:ul) do
      safe_join(choices.map { |c| choice(c) })
    end
  end

  private

  # overwritten, added matrix row body
  def choice(choice_hash)
    content_tag :li do
      if choice_hash[:row_body].present?
        "#{translated_attribute(choice_hash[:row_body])} - #{render_body_for choice_hash}"
      else
        render_body_for choice_hash
      end
    end
  end
end