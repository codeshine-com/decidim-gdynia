# frozen_string_literal: true

module Decidim
  module Core
    module Extended

      class AuthorizationsController < Decidim::AccountController
        # include Decidim::FormFactory
        # include Decidim::UserProfile

        # skip_before_action :ensure_profile_holder
        # skip_before_action :ensure_profile_holder_is_a_group, only: [:members]
        # skip_before_action :ensure_profile_holder_is_a_user, only: [:groups, :following]
        # skip_before_action :ensure_user_not_blocked, only: [:following, :followers, :badges]

        # helper_method :profile_holder, :active_content
        #
        # before_action :ensure_profile_holder
        # before_action :ensure_profile_holder_is_a_group, only: [:members]
        def show
          enforce_permission_to :show, :user, current_user: current_user
          @form = Decidim::Core::Extended::AuthorizationInhabitantCardForm.new
        end

        def create
          enforce_permission_to :show, :user, current_user: current_user
          @form = Decidim::Core::Extended::AuthorizationInhabitantCardForm.from_params(inhabitant_card_params)

          Decidim::Core::Extended::InhabitantCardAuthorization.call(current_user, @form) do
            on(:ok) do
              redirect_to decidim_core_extended.inhabitant_cards_path, notice: I18n.t("authenticate.success", scope: "decidim.inhabitant_card_authorization")
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

        # def profile_holder
        #   @profile_holder ||= current_user
        # end

      end
    end
  end
end
