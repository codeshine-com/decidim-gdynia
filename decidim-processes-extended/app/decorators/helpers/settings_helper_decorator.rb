# frozen_string_literal: true

Decidim::Admin::SettingsHelper.class_eval do

  # def settings_attribute_input(form, attribute, name, i18n_scope, options = {})
  #   form_method = form_method_for_attribute(attribute)
  #
  #   container_class = "#{name}_container"
  #   if options[:readonly]
  #     container_class += " readonly_container"
  #     help_text = text_for_setting(name, "readonly", i18n_scope)
  #   end
  #   help_text ||= text_for_setting(name, "help", i18n_scope)
  #   help_text_options = help_text ? { help_text: help_text } : {}
  #
  #   options = { label: t(name, scope: i18n_scope) }
  #             .merge(help_text_options)
  #             .merge(extra_options_for_type(form_method))
  #             .merge(options)
  #
  #   content_tag(:div, class: container_class) do
  #     if attribute.translated?
  #       options[:tabs_id] = "#{options.delete(:tabs_prefix)}-#{name}-tabs"
  #       form.send(:translated, form_method, name, options)
  #     elsif form_method == :collection_radio_buttons
  #       render_enum_form_field(form, attribute, name, i18n_scope, options)
  #     elsif form_method == :scope_field
  #       scopes_picker_field(form, name)
  #     else
  #       form.send(form_method, name, options)
  #     end
  #   end.html_safe
  # end
end
