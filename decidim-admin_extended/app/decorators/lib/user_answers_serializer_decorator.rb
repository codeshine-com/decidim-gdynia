# frozen_string_literal: true

Decidim::Forms::UserAnswersSerializer.class_eval do

  # store mapped question keys like: "position question key" => "question key with fixed position"
  attr_accessor :keys_map

  def serialize
    answers_hash = hash_for(@answers.first)
    @keys_map = {}

    answers_hash.merge!(questions_hash)

    @answers.each do |answer|
      if answer.question.matrix?
        answers_hash.update(matrix_response_for(answer))
      elsif answer.question.multiple_choice? && !answer.question.single_option?
        answers_hash.update(choices_response_for(answer))
      else
        key = lp_question_key(answer.question.position, answer.question)
        answers_hash[key] = if answer.question.single_option?
                              # odpowiedzi nie sa obowiazkowe
                              [answer.choices.first&.body, answer.choices.first&.custom_body].compact.join(' - ')
                            else
                              answer.body.presence
                            end
      end
    end

    answers_hash
  end

  def automatic_question_numbering?
    @automatic_question_numbering ||= begin
                                        questionnaire_id = @answers.first&.decidim_questionnaire_id
                                        return unless questionnaire_id

                                        questions = Decidim::Forms::Question.where(decidim_questionnaire_id: questionnaire_id)
                                        return if questions.none?

                                        questions.last.questionnaire.questionnaire_for.automatic_question_numbering?
                                      end
  end

  private

  def questions_hash
    questionnaire_id = @answers.first&.decidim_questionnaire_id
    return {} unless questionnaire_id

    questions = Decidim::Forms::Question.where(decidim_questionnaire_id: questionnaire_id)
    return {} if questions.none?

    lp = -1 # because question_key adds +1 for numbering
    questions.not_separator.not_title_and_description.order(:position).each.inject({}) do |serialized, question|
      idx = question.position
      lp += 1

      if question.matrix?
        question.matrix_rows.each do |matrix_row|
          if question.single_option?
            @keys_map.update(question_key(idx, question, matrix_row) => question_key(lp, question, matrix_row))
            serialized.update(
              question_key(lp, question, matrix_row) => ""
            )
          else
            question.answer_options.map do |answer_option|
              @keys_map.update(question_key(idx, question, matrix_row, answer_option) => question_key(lp, question, matrix_row, answer_option))
              serialized.update(
                question_key(lp, question, matrix_row, answer_option) => ""
              )
            end
          end
        end
      elsif question.multiple_choice? && !question.single_option?
        question.answer_options.each do |answer_option|
          @keys_map.update(question_key(idx, question, answer_option) => question_key(lp, question, answer_option))
          serialized.update(
            question_key(lp, question, answer_option) => ""
          )
        end
      else
        # for short_answer long_answer and single_option
        @keys_map.update(question_key(idx, question) => question_key(lp, question))
        serialized.update(
          question_key(lp, question) => ""
        )
      end

      serialized
    end
  end

  # remove question number unless automatic_question_numbering is on
  def question_key(idx, question, matrix_row = nil, answer_option = nil)
    text = [question, matrix_row, answer_option].compact.map { |item| translated_attribute(item.body) }.join(" - ")
    automatic_question_numbering? ? "#{idx + 1}. #{text}" : text
  end

  # question key fixed for proper ordered question positioning
  def lp_question_key(idx, question, matrix_row = nil, answer_option = nil)
    @keys_map[question_key(idx, question, matrix_row, answer_option)]
  end

  def choices_response_for(answer)
    h = {}
    answer.choices.each do |choice|
      key = lp_question_key(answer.question.position, answer.question, choice.answer_option)
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
        key = lp_question_key(answer.question.position, answer.question, choice.matrix_row)
        h[key] = [choice.body, choice.custom_body].compact.join(' - ')
      else
        key = lp_question_key(answer.question.position + 1, answer.question, choice.matrix_row, choice.answer_option)
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