# frozen_string_literal: true

module Decidim
  module Assemblies
    module Extended
      # A form object used to create cadency from the admin dashboard.
      class CadencyForm < Form
        include TranslatableAttributes

        mimic :cadency

        translatable_attribute :name, String
        attribute :weight, Integer, default: 0

        validates :name, translatable_presence: true
      end
    end
  end
end
