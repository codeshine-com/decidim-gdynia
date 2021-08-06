# frozen_string_literal: true

Decidim::DecidimFormHelper.class_eval do

  def scopes_for_select(organization)
    return organization.scopes.promoted_first if organization.scope_types.blank?
    return organization.scopes.promoted_first if organization.scope_types.all? { |st| st.scope_ids.empty? }

    organization.scope_types
  end
end
