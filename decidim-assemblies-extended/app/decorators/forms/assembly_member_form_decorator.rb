# frozen_string_literal: true

Decidim::Assemblies::Admin::AssemblyMemberForm.class_eval do
  include Decidim::TranslatableAttributes
  include Decidim::HasUploadValidations

  attribute :assembly_id, Integer
  attribute :affiliation, String
  attribute :cadency_id, Integer
  attribute :representation, String

  attribute :avatar
  # attribute :remove_avatar

  validates :avatar, passthru: { to: Decidim::AssemblyMember }

  def cadencies_for_select(current_assembly)
    @cadencies_for_select ||= current_assembly.cadencies.order('weight DESC')
                                  &.map { |pp| [translated_attribute(pp.name), pp.id] }
  end

  def map_model(model)
    self.user_id = model.decidim_user_id
    self.existing_user = user_id.present?
    self.cadency_id = model.decidim_assemblies_extended_cadency_id
  end
end
