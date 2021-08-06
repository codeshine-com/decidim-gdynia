# frozen_string_literal: true

Decidim::Admin::UpdateArea.class_eval do

  private

  def attributes
    {
      name: form.name,
      area_type: form.area_type,
      icon: form.icon.presence || nil,
      remove_icon: form.remove_icon
    }
  end
end
