module Decidim
  module Core
    module Extended

      class GroupsController < Decidim::ProfilesController
        include Decidim::FormFactory
        include Decidim::UserGroups

        before_action :enforce_user_groups_enabled
        # helper_method :profile_holder, :active_content
        #
        # before_action :ensure_profile_holder
        # before_action :ensure_profile_holder_is_a_group, only: [:members]

        def delete
          @user_group = user_group
          enforce_permission_to :manage, :user_group, current_user: current_user, user_group: user_group

          @form = form(Decidim::DeleteAccountForm).from_model(user_group)
        end

        def destroy
          enforce_permission_to :manage, :user_group, current_user: current_user, user_group: user_group
          p 'initializeinitializeinitialize'
          p params
          @form = form(Decidim::DeleteAccountForm).from_params(params)

          Decidim::DestroyUserGroup.call(user_group, @form) do
            on(:ok) do
              # sign_out(current_user)
              flash[:notice] = t("account.destroy.success", scope: "decidim")
            end

            on(:invalid) do
              flash[:alert] = t("account.destroy.error", scope: "decidim")
            end
          end

          redirect_to decidim.profile_path(current_user.nickname)
        end

        private

        def accepted_user_group
          @accepted_user_group ||= Decidim::UserGroups::AcceptedUserGroups.for(current_user).find_by(nickname: params[:id])
        end

        def user_group
          @user_group ||= Decidim::UserGroups::ManageableUserGroups.for(current_user).find_by(nickname: params[:id])
        end

        def user_group_params
          params[:group].merge(id: user_group.id)
        end

        def profile_holder
          return if params[:id].blank?

          @profile_holder ||= Decidim::UserGroup.find_by(
            nickname: params[:id],
            organization: current_organization
          )
        end
      end
    end
  end
end
