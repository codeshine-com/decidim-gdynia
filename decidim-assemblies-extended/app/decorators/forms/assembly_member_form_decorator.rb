# frozen_string_literal: true

Decidim::Assemblies::Admin::AssemblyMemberForm.class_eval do
  include Decidim::TranslatableAttributes
  include Decidim::HasUploadValidations

  attribute :assembly_id, Integer
  attribute :affiliation, String
  attribute :cadency_id, Integer
  attribute :representation, String

  attribute :avatar
  attribute :remove_avatar, Decidim::AttributeObject::TypeMap::Boolean, default: false

  validates :avatar, passthru: {
    to: Decidim::AssemblyMember,
    with: {
      # The member gets its organization context through the assembly
      # object which is why we need to create a dummy assembly in order
      # to pass the correct organization context to the file upload
      # validators.
      assembly: lambda do |form|
        Decidim::Assembly.new(organization: form.current_organization)
      end
    }
  }

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
