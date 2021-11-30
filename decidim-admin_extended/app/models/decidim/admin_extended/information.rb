# frozen_string_literal: true

module Decidim::AdminExtended
  class Information < ApplicationRecord
    belongs_to :organization,
               foreign_key: "decidim_organization_id",
               class_name: "Decidim::Organization"

    default_scope { order(created_at: :desc) }
  end
end
