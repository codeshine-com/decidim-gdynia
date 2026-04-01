# frozen_string_literal: true

Decidim::Exporters::FormPDF.class_eval do

  # overwritten: add automatic_question_numbering
  def add_response_box(record, index)
    composer.text(I18n.t("title", number: index + 1, scope: "decidim.forms.admin.questionnaires.answers.export.answer"), style: :section_title)
    add_user_data(record)

    automatic_question_numbering = record.questionnaire.questionnaire_for.automatic_question_numbering?

    record.answers.each_with_index do |answer, ind|
      question = automatic_question_numbering ? "#{ind + 1}. #{answer.question}" : answer.question
      composer.text(question, style: :question_title)

      add_answer_body(answer)
    end
  end
end