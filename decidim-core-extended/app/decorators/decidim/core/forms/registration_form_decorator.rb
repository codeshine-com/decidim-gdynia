# frozen_string_literal: true

Decidim::RegistrationForm.class_eval do
  attr_accessor :rodo_agreements
  attribute :card_number

  validates :rodo_agreements, allow_nil: false, acceptance: true

  validates :tos_agreement, presence: true
  validates :rodo_agreements, presence: true

  # TODO: walidacja unikalnosci
  validate :is_card_number_uniqie?

  def is_card_number_uniqie?
    return if card_number.blank?

    errors.add(:card_number, I18n.t('activemodel.attributes.user.inhabitant_card_taken_error')) if Decidim::User.where(inhabitant_card_number: card_number).any?
  end
end
