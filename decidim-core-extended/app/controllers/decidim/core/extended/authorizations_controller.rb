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
          @account = form(Decidim::AccountForm).from_model(current_user)
        end

        def create
          ## TODO: laczenie z karta mieszkanca
        end


        private

        def profile_holder
          @profile_holder ||= current_user
        end

      end
    end
  end
end
