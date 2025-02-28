# frozen_string_literal: true

Decidim::Forms::UserAnswersSerializer.class_eval do

  def serialize
    answers_hash = hash_for(@answers.first)
    answers_hash.merge!(questions_hash)

    @answers.each do |answer|
      if answer.question.matrix?
        answers_hash.update(matrix_response_for(answer))
      elsif answer.question.multiple_choice? && !answer.question.single_option?
        answers_hash.update(choices_response_for(answer))
      else
        key = question_key(answer.question.position, answer.question)
        answers_hash[key] = if answer.question.single_option?
                              [answer.choices.first.body, answer.choices.first.custom_body].compact.join(' - ')
                            else
                              answer.body.presence
                            end
      end
    end

    answers_hash
  end

  private

  def questions_hash
    questionnaire_id = @answers.first&.decidim_questionnaire_id
    return {} unless questionnaire_id

    questions = Decidim::Forms::Question.where(decidim_questionnaire_id: questionnaire_id)
    return {} if questions.none?

    questions.not_separator.not_title_and_description.each.inject({}) do |serialized, question|
      idx = question.position

      if question.matrix?
        question.matrix_rows.each do |matrix_row|
          if question.single_option?
            serialized.update(
              question_key(idx, question, matrix_row) => ""
            )
          else
            question.answer_options.map do |answer_option|
              serialized.update(
                question_key(idx, question, matrix_row, answer_option) => ""
              )
            end
          end
        end
      elsif question.multiple_choice? && !question.single_option?
        question.answer_options.each do |answer_option|
          serialized.update(
            question_key(idx, question, answer_option) => ""
          )
        end
      else
        # for short_answer long_answer and single_option
        serialized.update(
          question_key(idx, question) => ""
        )
      end

      serialized
    end
  end

  def question_key(idx, question, matrix_row = nil, answer_option = nil)
    text = [question, matrix_row, answer_option].compact.map { |item| translated_attribute(item.body) }.join(" - ")
    "#{idx + 1}. #{text}"
  end

  def choices_response_for(answer)
    h = {}
    answer.choices.each do |choice|
      key = question_key(answer.question.position, answer.question, choice.answer_option)
      h[key] = if choice.custom_body.present?
                 [choice.body, choice.custom_body].compact.join(' - ')
               else
                 1
               end
    end
    h
  end

  def matrix_response_for(answer)
    h = {}
    answer.choices.each do |choice|
      if answer.question.single_option?
        key = question_key(answer.question.position, answer.question, choice.matrix_row)
        h[key] = [choice.body, choice.custom_body].compact.join(' - ')
      else
        key = question_key(answer.question.position + 1, answer.question, choice.matrix_row, choice.answer_option)
        h[key] = if choice.custom_body.present?
                   [choice.body, choice.custom_body].compact.join(' - ')
                 else
                   1
                 end
      end
    end
    h
  end

end