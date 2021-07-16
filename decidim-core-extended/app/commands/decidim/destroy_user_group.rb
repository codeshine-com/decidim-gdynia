# frozen_string_literal: true

module Decidim
  # This command destroys the user's account.
  class DestroyUserGroup < Rectify::Command
    # Destroy a user's account.
    #
    # user - The user to be updated.
    # form - The form with the data.
    def initialize(user_group, form)
      @user_group = user_group
      @form = form
    end

    def call
      return broadcast(:invalid) unless @form.valid?

      Decidim::UserGroup.transaction do
        destroy_user_group!
        # destroy_user_identities
        destroy_user_group_memberships
        destroy_follows
        # destroy_participatory_space_private_user
        # delegate_destroy_to_participatory_spaces
      end

      broadcast(:ok)
    end

    private

    def destroy_user_group!
      @user_group.name = ""
      @user_group.nickname = ""
      @user_group.email = ""
      @user_group.delete_reason = @form.delete_reason
      @user_group.deleted_at = Time.current
      @user_group.skip_reconfirmation!
      @user_group.remove_avatar!
      @user_group.save!(validate: false)
    end

    # user groups do not have identities
    # def destroy_user_identities
    #   @user_group.identities.destroy_all
    # end

    def destroy_user_group_memberships
      Decidim::UserGroupMembership.where(user_group: @user_group).destroy_all
    end

    def destroy_follows
      Decidim::Follow.where(followable: @user_group).destroy_all
      Decidim::Follow.where(user: @user_group).destroy_all
    end

    # group_userds can not be provate users
    # def destroy_participatory_space_private_user
    #   Decidim::ParticipatorySpacePrivateUser.where(user: @user).destroy_all
    # end

    # destroys roles - groups can not have roles
    # def delegate_destroy_to_participatory_spaces
    #   Decidim.participatory_space_manifests.each do |space_manifest|
    #     space_manifest.invoke_on_destroy_account(@user_group)
    #   end
    # end
  end
end
