# frozen_string_literal: true

Decidim::ParticipatoryProcesses::Admin::CreateParticipatoryProcess.class_eval do
  def call
    return broadcast(:invalid) if form.invalid?

    create_participatory_process

    if process.persisted?
      add_admins_as_followers(process)
      link_related_processes
      translate_areas_into_categories(process)
      # addes scopes
      # link_scopes
      broadcast(:ok, process)
    else
      form.errors.add(:hero_image, process.errors[:hero_image]) if process.errors.include? :hero_image
      form.errors.add(:banner_image, process.errors[:banner_image]) if process.errors.include? :banner_image
      broadcast(:invalid)
    end
  end

  private

  def create_participatory_process
    @process = Decidim::ParticipatoryProcess.new(
      organization: form.current_organization,
      title: form.title,
      subtitle: form.subtitle,
      weight: form.weight,
      slug: form.slug,
      hashtag: form.hashtag,
      description: form.description,
      short_description: form.short_description,
      hero_image: form.hero_image,
      banner_image: form.banner_image,
      promoted: form.promoted,
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
      ### our custom
      contact_address: form.contact_address
    )

    return process unless process.valid?

    transaction do
      process.save!

      log_process_creation(process)

      process.steps.create!(
        title: Decidim::TranslationsHelper.multi_translation(
          "decidim.admin.participatory_process_steps.default_title",
          form.current_organization.available_locales
        ),
        active: true
      )

      process
    end
  end

  def scopes
    @scopes ||= Decidim::Scope.where(id: form.scope_ids)
  end

  def link_scopes
    @participatory_process.link_participatory_space_resources(scopes, "scopes")
  end

  def translate_areas_into_categories(process)
    Decidim::Area.where(organization: process.organization).each do |area|
      process.categories.create(name: area.name, description: area.name)
    end
  end
end
