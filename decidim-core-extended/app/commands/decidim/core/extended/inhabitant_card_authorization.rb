# frozen_string_literal: true

module Decidim
  module Core
    module Extended
      class InhabitantCardAuthorization < Decidim::Command

        def initialize(user, form)
          @user = user
          @form = form
        end

        def call
          return broadcast(:invalid) unless user
          return broadcast(:invalid) if form.invalid?

          if verify_card
            handle_user
            broadcast(:ok)
          else
            form.errors.add(:email, t('activemodel.attributes.user.inhabitant_card_number_error'))
            form.errors.add(:card_number, t('activemodel.attributes.user.inhabitant_card_number_error'))
            broadcast(:invalid)
          end
        end

        private

        attr_reader :form, :user

        def verify_card
          Decidim::Core::Extended::InhabitantCardService.new(form).call
        end

        def handle_user
          if user.officialized?
            user.update_column('inhabitant_card_number', form.card_number)
          else
            user.update_columns(
              inhabitant_card_number: form.card_number,
              officialized_at: Time.current,
              officialized_as: t('activemodel.attributes.user.inhabitant_officialization_badge')
            )
          end
        end
      end
    end
  end
end
