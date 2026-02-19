# frozen_string_literal: true

module Decidim
  module Gdynia
    # Custom helpers, scoped to the gdynia engine.
    #
    module ApplicationHelper
      def card_number_uniqie?
        return if card_number.blank?
        return unless Decidim::User.where(inhabitant_card_number: card_number).any?

        errors.add(:card_number, I18n.t("activemodel.attributes.user.inhabitant_card_taken_error"))
      end
    end
  end
end
