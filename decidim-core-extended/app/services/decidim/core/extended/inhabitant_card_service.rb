# frozen_string_literal: true

module Decidim
  module Core
    module Extended
      class InhabitantCardService

        def initialize(form)
          @card_number = form.card_number
          @email = form.email
        end

        def call
          return false unless card_number.present? && email.present?
          return false

          ### TODO: Przemek
        end

        private

        attr_reader :card_number, :email

      end
    end
  end
end
