# frozen_string_literal: true

module Decidim
  # The form object that handles the data behind updating a user's
  # interests in her profile page.
  class UserInterestAreaForm < Form
    mimic :area

    attribute :name, JsonbAttributes
    attribute :checked, Boolean
    attribute :area_type, Decidim::AreaType

    def map_model(model_hash)
      area = model_hash[:area]
      user = model_hash[:user]
      area_type = model_hash[:area_type]

      self.id = area.id
      self.name = area.name
      self.checked = user.interested_areas_ids.include?(area.id)
      self.area_type = area_type
    end
  end
end
