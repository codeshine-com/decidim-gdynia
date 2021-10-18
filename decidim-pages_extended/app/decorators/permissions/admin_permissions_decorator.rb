# frozen_string_literal: true

Decidim::Admin::Permissions.class_eval do
  def permissions
    return permission_action if managed_user_action?

    unless permission_action.scope == :admin
      read_admin_dashboard_action?
      return permission_action
    end

    unless user
      disallow!
      return permission_action
    end

    if user_manager?
      begin
        allow! if user_manager_permissions.allowed?
      rescue Decidim::PermissionAction::PermissionNotSetError
        nil
      end
    end

    allow! if user_can_enter_space_area?(require_admin_terms_accepted: true)

    # custom
    if user_can_handle_attachments_in_page_extended_engine?
      allow!
      return permission_action
    end

    read_admin_dashboard_action?
    apply_newsletter_permissions_for_admin!

    allow! if permission_action.subject == :global_moderation

    if user.admin? && admin_terms_accepted?
      allow! if read_admin_log_action?
      allow! if read_metrics_action?
      allow! if static_page_action?
      allow! if organization_action?
      allow! if user_action?

      allow! if permission_action.subject == :category
      allow! if permission_action.subject == :component
      allow! if permission_action.subject == :admin_user
      allow! if permission_action.subject == :attachment
      allow! if permission_action.subject == :attachment_collection
      allow! if permission_action.subject == :scope
      allow! if permission_action.subject == :scope_type
      allow! if permission_action.subject == :area
      allow! if permission_action.subject == :area_type
      allow! if permission_action.subject == :user_group
      allow! if permission_action.subject == :officialization
      allow! if permission_action.subject == :moderate_users
      allow! if permission_action.subject == :authorization
      allow! if permission_action.subject == :authorization_workflow
      allow! if permission_action.subject == :static_page_topic
      allow! if permission_action.subject == :help_sections
      allow! if permission_action.subject == :share_token
    end

    permission_action
  end

  def user_can_handle_attachments_in_page_extended_engine?
    return unless permission_action.subject == :page_extended
    return unless page

    user.admin? || can_manage_pages_space?
  end

  def page
    @page ||= context.fetch(:page, nil)
  end

  def space
    @space ||= page.participatory_space
  end

  def can_manage_pages_space?
    if space.is_a?(Decidim::ParticipatoryProcess)
      Decidim::ParticipatoryProcessesWithUserRole.for(user, :admin).include?(space)
    elsif space.is_a?(Decidim::Assembly)
      Decidim::Assemblies::AssembliesWithUserRole.for(user, :admin).include?(space)
    end
  end
end
