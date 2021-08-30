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
        destroy_user_group_memberships
        destroy_follows
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

    def destroy_user_group_memberships
      Decidim::UserGroupMembership.where(user_group: @user_group).destroy_all
    end

    def destroy_follows
      Decidim::Follow.where(followable: @user_group).destroy_all
      Decidim::Follow.where(user: @user_group).destroy_all
    end
  end
end
