# frozen_string_literal: true

Decidim::Assemblies::Admin::CreateAssembly.class_eval do

  private

  def assembly
    @assembly ||= Decidim.traceability.create(
      Decidim::Assembly,
      form.current_user,
      organization: form.current_organization,
      title: form.title,
      subtitle: form.subtitle,
      slug: form.slug,
      hashtag: form.hashtag,
      description: form.description,
      short_description: form.short_description,
      hero_image: form.hero_image,
      banner_image: form.banner_image,
      promoted: form.promoted,
      scopes_enabled: form.scopes_enabled,
      scope: form.scope,
      area: form.area,
      parent: form.parent,
      private_space: form.private_space,
      developer_group: form.developer_group,
      local_area: form.local_area,
      target: form.target,
      participatory_scope: form.participatory_scope,
      participatory_structure: form.participatory_structure,
      meta_scope: form.meta_scope,
      show_statistics: form.show_statistics,
      purpose_of_action: form.purpose_of_action,
      composition: form.composition,
      assembly_type: form.assembly_type,
      creation_date: form.creation_date,
      created_by: form.created_by,
      created_by_other: form.created_by_other,
      duration: form.duration,
      included_at: form.included_at,
      closing_date: form.closing_date,
      closing_date_reason: form.closing_date_reason,
      internal_organisation: form.internal_organisation,
      is_transparent: form.is_transparent,
      special_features: form.special_features,
      twitter_handler: form.twitter_handler,
      facebook_handler: form.facebook_handler,
      instagram_handler: form.instagram_handler,
      youtube_handler: form.youtube_handler,
      github_handler: form.github_handler,
      announcement: form.announcement,
      weight: form.weight,
      # customized - our custom fields
      contact_address: form.contact_address,
      contact_email: form.contact_email,
      contact_phone: form.contact_phone,
      duration_text: form.duration_text,
      team_service: form.team_service,
      next_meeting_date: form.next_meeting_date
    )
  end
end
