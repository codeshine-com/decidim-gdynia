# frozen_string_literal: true

Decidim::RegistrationForm.class_eval do
  include Decidim::Gdynia::ApplicationHelper

  attribute :card_number_possesion, Decidim::AttributeObject::TypeMap::Boolean
  attribute :card_number, String

  validate :card_number_uniqie?
end
