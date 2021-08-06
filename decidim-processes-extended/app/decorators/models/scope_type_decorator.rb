# frozen_string_literal: true

Decidim::ScopeType.class_eval do
  include Decidim::TranslatableAttributes
  include Decidim::TranslatableResource

  def translated_name
    @translated_name ||= translated_attribute name
  end
end
