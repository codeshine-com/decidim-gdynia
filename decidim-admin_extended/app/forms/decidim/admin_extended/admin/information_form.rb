# frozen_string_literal: true

module Decidim
  module AdminExtended
    module Admin
      class InformationForm < Form
        attribute :name, String
        attribute :body, String
        attribute :lead, String
        attribute :link_url, String
        attribute :published, GraphQL::Types::Boolean

        validates :name, presence: true
        validates :body, presence: true

        mimic :information

        alias organization current_organization
      end
    end
  end
end
