# frozen_string_literal: true

Decidim::ScopesHelper.class_eval do

  def scopes_picker_filter(form, name, checkboxes_on_top: true)

    form.scopes_select name,
                      scopes_for_select(current_organization),
                      legend_title: t("decidim.scopes.scopes"),
                      label: "",
                      multiple: false,
                      selected: form.try(:scope_id),
                      include_blank: t("decidim.admin.shared.settings_fields.select_a_scope")
  end

  def scopes_picker_field(form, name, root: false, options: { checkboxes_on_top: true })
    if root
      form.scopes_picker name, options do |scope|
        { url: decidim.scopes_picker_path(root: root, current: scope&.id, field: form.label_for(name)),
          text: scope_name_for_picker(scope, I18n.t("decidim.scopes.global")) }
      end
    else
      scopes = try(:current_participatory_space)&.scopes&.promoted_first || []
      form.select(
        name,
        scopes.map{|scope| [translated_attribute(scope.name), scope.id, class: "#{scope.promoted ? 'promoted-scope' : nil}"  ]},
        { include_blank: true },
        { multiple: false }
      )
    end
  end
end
