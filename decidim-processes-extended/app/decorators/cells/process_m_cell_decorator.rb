# frozen_string_literal: true

Decidim::ParticipatoryProcesses::ProcessMCell.class_eval do
  def show
    render :show_new
  end

  def step_cta_text
    if translated_in_current_locale?(model.active_step&.cta_text)
      translated_attribute(model.active_step.cta_text)
    else
      t(model.cta_button_text_key_accessible, resource_name: '', scope: "layouts.decidim.participatory_processes.participatory_process")
    end
  end

  def statuses
    [:scopes, :follow]
  end

  def scopes_status
    # explanation = content_tag(:strong, t("activemodel.attributes.common.scope").upcase)
    # "#{explanation} #{model.scopes.promoted_first.map { |scope| "#{translated_attribute(scope.name)}" }.join('<br>')}"
    "#{model.scopes.promoted_first.map { |scope| "#{translated_attribute(scope.name)}" }.join('<br>')}"
  end
end
