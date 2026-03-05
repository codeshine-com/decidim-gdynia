# frozen_string_literal: true

Decidim::Forms::AnswerForm.class_eval do
  # overwritten, remove idx from question title
  def label(idx)
    base = if idx
             "#{idx + 1}. #{translated_attribute(question.body)}"
           else
             translated_attribute(question.body)
           end
    base += " #{mandatory_label}" if question.mandatory?
    base += " (#{max_choices_label})" if question.max_choices
    base
  end
end