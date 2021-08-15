# frozen_string_literal: true

Decidim::Forms::Admin::AnswerOptionForm.class_eval do

  # clear_validators!
  # validates :body, translatable_presence: true, unless: proc { |form| form.deleted }

end
