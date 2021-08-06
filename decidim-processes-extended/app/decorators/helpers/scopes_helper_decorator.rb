# frozen_string_literal: true

Decidim::ScopesHelper.class_eval do

  def scopes_picker_filter(form, name, checkboxes_on_top: true)

    form.scopes_select name,
                      scopes_for_select(current_organization),
                      legend_title: t("decidim.scopes.scopes"),
                      label: "",
                      multiple: controller_name == 'participatory_processes',
                      selected: filter.try(:scope_id),
                      include_blank: t(".select_a_scope")

  end
end
