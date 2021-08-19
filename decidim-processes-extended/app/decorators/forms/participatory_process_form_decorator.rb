# frozen_string_literal: true

Decidim::ParticipatoryProcesses::Admin::ParticipatoryProcessForm.class_eval do
  attribute :related_scope_ids, Array[Integer]

  attribute :contact_address, String
  attribute :contact_email, String
  attribute :contact_phone, String
  attribute :facebook_handler, String

  def map_model(model)
    self.scope_id = model.decidim_scope_id
    self.participatory_process_group_id = model.decidim_participatory_process_group_id
    self.related_process_ids = model.linked_participatory_space_resources(:participatory_process, "related_processes").pluck(:id)
    # added shopes
    self.related_scope_ids = model.linked_participatory_space_resources(:scope, "related_scopes").pluck(:id)
    @processes = Decidim::ParticipatoryProcess.where(organization: model.organization).where.not(id: model.id)
  end

  def scopes
    @scopes ||= Decidim::Scope.where(organization: current_organization)
  end
end
