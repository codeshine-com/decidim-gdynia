# frozen_string_literal: true

Decidim::Assemblies::Admin::UpdateAssemblyMember.class_eval do

  def initialize(form, assembly_member)
    form.avatar = assembly_member.avatar if form.avatar.blank?
    @form = form
    @assembly_member = assembly_member
  end

  private

  def update_assembly_member!
    log_info = {
      resource: {
        title: assembly_member.full_name
      },
      participatory_space: {
        title: assembly_member.assembly.title
      }
    }

    Decidim.traceability.update!(
      assembly_member,
      form.current_user,
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
        user: form.user,
        avatar: form.avatar.presence || nil
      ),
      log_info
    )
  end
end
