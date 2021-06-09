# frozen_string_literal: true

Decidim::Assemblies::Admin::CreateAssemblyMember.class_eval do

  private

  def create_assembly_member!
    log_info = {
      resource: {
        title: form.full_name
      },
      participatory_space: {
        title: assembly.title
      }
    }

    @assembly_member = Decidim.traceability.create!(
      Decidim::AssemblyMember,
      current_user,
      form.attributes.slice(
        :full_name,
        :gender,
        :birthday,
        :birthplace,
        :ceased_date,
        :designation_date,
        :designation_mode,
        :position,
        :position_other,
        :weight,
        # customized - our custom fields
        :affiliation,
        :representation
      ).merge(
        assembly: assembly,
        user: form.user
      ),
      log_info
    )
  end
end
