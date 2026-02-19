# frozen_string_literal: true

module Decidim
  module Gdynia
    class AuthorizationsController < Decidim::AccountController
      def show
        @form = Decidim::Gdynia::AuthorizationInhabitantCardForm.new
      end

      def create
        @form = Decidim::Gdynia::AuthorizationInhabitantCardForm.from_params(inhabitant_card_params)

        Decidim::Gdynia::InhabitantCardAuthorization.call(current_user, @form) do
          on(:ok) do
            redirect_to decidim_gdynia.inhabitant_cards_path, notice: I18n.t("authenticate.success", scope: "decidim.inhabitant_card_authorization")
          end

          on(:invalid) do
            flash.now[:alert] = I18n.t("authenticate.invalid", scope: "decidim.inhabitant_card_authorization")
            render action: "show"
          end
        end
      end

      private

      def inhabitant_card_params
        params[:inhabitant_card].to_unsafe_h
      end
    end
  end
end
