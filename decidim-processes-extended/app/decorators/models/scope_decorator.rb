# frozen_string_literal: true

Decidim::Scope.class_eval do
  include Decidim::ParticipatorySpaceResourceable
  include Decidim::TranslatableAttributes

  def self.promoted_first(organization_id = nil)
    query = order('promoted DESC')
    query = query.where(decidim_organization_id: organization_id) if organization_id
    query
  end

  def translated_name
    @translated_name ||= translated_attribute name
  end
end
