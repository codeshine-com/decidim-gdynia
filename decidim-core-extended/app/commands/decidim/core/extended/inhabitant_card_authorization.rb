# frozen_string_literal: true

module Decidim
  module Core
    module Extended
      class InhabitantCardAuthorization < Rectify::Command

        def initialize(user, form)
          @user = user
          @form = form
        end

        def call
          return broadcast(:invalid) if form.invalid?

          if verify_card
            handle_user
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
          if user
            # for authorization of existing user
            user.update_column('inhabitant_card_number', form.card_number)
          else
            # for registration with inhabitant card params
            # TODO - moze przeniesc do commanda od rejestracji
            @user = Decidim::User.create!(
              email: form.email,
              name: form.name,
              nickname: form.nickname,
              password: form.password,
              password_confirmation: form.password_confirmation,
              organization: form.current_organization,
              tos_agreement: form.tos_agreement,
              newsletter_notifications_at: form.newsletter_at,
              email_on_notification: true,
              accepted_tos_version: form.current_organization.tos_version,
              locale: form.current_locale,
              inhabitant_card_number: form.inhabitant_card_number
            )
          end
        end
      end
    end
  end
end
