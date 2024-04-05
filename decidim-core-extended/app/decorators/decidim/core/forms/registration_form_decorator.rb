# frozen_string_literal: true

Decidim::RegistrationForm.class_eval do
  attribute :card_number, String
  attribute :card_number_possesion, Decidim::AttributeObject::TypeMap::Boolean
  attribute :rodo_agreements, Decidim::AttributeObject::TypeMap::Boolean

  validates :rodo_agreements, allow_nil: false, acceptance: true

  # TODO: walidacja unikalnosci
  validate :is_card_number_uniqie?

  def is_card_number_uniqie?
    return if card_number.blank?

    errors.add(:card_number, I18n.t('activemodel.attributes.user.inhabitant_card_taken_error')) if Decidim::User.where(inhabitant_card_number: card_number).any?
  end
end
