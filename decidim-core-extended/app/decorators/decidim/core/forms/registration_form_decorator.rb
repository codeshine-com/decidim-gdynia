# frozen_string_literal: true

Decidim::RegistrationForm.class_eval do
  attr_accessor :rodo_agreements

  validates :rodo_agreements, allow_nil: false, acceptance: true
end
