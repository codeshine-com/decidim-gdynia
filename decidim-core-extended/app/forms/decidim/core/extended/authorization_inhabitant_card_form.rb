# frozen_string_literal: true

require "valid_email2"

module Decidim
  module Core
    module Extended
      class AuthorizationInhabitantCardForm < Form
        attribute :email
        attribute :card_number

        validates :email, presence: true, 'valid_email_2/email': { disposable: true }
        validates :card_number, presence: true

        validate :is_card_number_uniqie?

        def is_card_number_uniqie?
          return if card_number.blank?

          errors.add(:card_number, I18n.t('activemodel.attributes.user.inhabitant_card_taken_error')) if Decidim::User.where(inhabitant_card_number: card_number).any?
        end
      end
    end
  end
end
