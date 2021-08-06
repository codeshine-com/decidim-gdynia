# frozen_string_literal: true

Decidim::Admin::UpdateScope.class_eval do

  private

  def attributes
    {
      name: form.name,
      code: form.code,
      scope_type: form.scope_type,
      # custom
      promoted: form.promoted
    }
  end
end
