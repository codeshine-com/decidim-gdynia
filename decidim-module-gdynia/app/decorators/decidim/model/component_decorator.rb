# frozen_string_literal: true

Decidim::Component.class_eval do
  # only for surveys
  def automatic_question_numbering?
    settings.automatic_question_numbering
  end
end
