# frozen_string_literal: true

Decidim::ParticipatoryProcesses::Admin::ParticipatoryProcessForm.class_eval do
  attribute :scope_ids, Array[Integer]

  attribute :contact_address, String
  attribute :facebook_handler, String

  def map_model(model)
    self.scope_id = model.decidim_scope_id
    self.participatory_process_group_id = model.decidim_participatory_process_group_id
    self.related_process_ids = model.linked_participatory_space_resources(:participatory_process, "related_processes").pluck(:id)
    # added shopes
    # self.scope_ids = linked_scope_resources("scopes").pluck(:id)
    @processes = Decidim::ParticipatoryProcess.where(organization: model.organization).where.not(id: model.id)
  end

  def scopes
    @scopes ||= Decidim::Scope.where(organization: current_organization)
  end

  def linked_scope_resources(link_name)
    klass = Decidim::Scope
    from = klass
           .joins(:participatory_space_resource_links_from)
           .where(decidim_participatory_space_links: { name: link_name, to_id: id, to_type: self.class.name })

    to = klass
         .joins(:participatory_space_resource_links_to)
         .where(decidim_participatory_space_links: { name: link_name, from_id: id, from_type: self.class.name })

    klass.where(id: from).or(klass.where(id: to))
  end
end
