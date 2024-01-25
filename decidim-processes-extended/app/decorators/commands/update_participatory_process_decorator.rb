# frozen_string_literal: true

Decidim::ParticipatoryProcesses::Admin::UpdateParticipatoryProcess.class_eval do

  private

  def attributes
          {
            title: form.title,
            subtitle: form.subtitle,
            weight: form.weight,
            slug: form.slug,
            hashtag: form.hashtag,
            promoted: form.promoted,
            description: form.description,
            short_description: form.short_description,
            scopes_enabled: form.scopes_enabled,
            scope: form.scope,
            scope_type_max_depth: form.scope_type_max_depth,
            private_space: form.private_space,
            developer_group: form.developer_group,
            local_area: form.local_area,
            area: form.area,
            target: form.target,
            participatory_scope: form.participatory_scope,
            participatory_structure: form.participatory_structure,
            meta_scope: form.meta_scope,
            start_date: form.start_date,
            end_date: form.end_date,
            participatory_process_group: form.participatory_process_group,
            show_metrics: form.show_metrics,
            show_statistics: form.show_statistics,
            announcement: form.announcement,
            ### our custom
            contact_address: form.contact_address,
            contact_email: form.contact_email,
            contact_phone: form.contact_phone,
            facebook_handler: form.facebook_handler
          }.merge(
            attachment_attributes(:hero_image, :banner_image)
          )
        end

  def update_participatory_process
    @participatory_process.assign_attributes(attributes)
    return unless @participatory_process.valid?

    @participatory_process.save!

    Decidim.traceability.perform_action!(:update, @participatory_process, form.current_user) do
      @participatory_process
    end
    link_related_processes
    # addes scopes
    link_related_scopes
  end

  def related_scopes
    @related_scopes ||= Decidim::Scope.where(id: form.related_scope_ids)
  end

  def link_related_scopes
    @participatory_process.link_participatory_space_resources(related_scopes, "related_scopes")
  end
end
