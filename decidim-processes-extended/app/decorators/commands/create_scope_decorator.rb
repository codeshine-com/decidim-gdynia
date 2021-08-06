# frozen_string_literal: true

Decidim::Admin::CreateScope.class_eval do

  private

  def create_scope
    Decidim.traceability.create!(
      DEcidim::Scope,
      form.current_user,
      {
        name: form.name,
        organization: form.organization,
        code: form.code,
        scope_type: form.scope_type,
        parent: @parent_scope,
        # custom
        promoted: form.promoted
      },
      extra: {
        parent_name: @parent_scope.try(:name),
        scope_type_name: form.scope_type.try(:name)
      }
    )
  end
end
