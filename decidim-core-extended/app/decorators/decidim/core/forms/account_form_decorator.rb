# frozen_string_literal: true

require "valid_email2"

Decidim::AccountForm .class_eval do
  include Decidim::TranslationsHelper

  attribute :gender
  attribute :birth_year
  attribute :district
  attribute :inhabitant_card_number

  validates :birth_year, numericality: { only_integer: true, greater_than: Date.current.year - 120, less_than: Date.current.year + 1, allow_nil: true }, if: proc { |attr| attr[:birth_year].present? || !attr[:birth_year].nil? }

  def genders_for_select
    Decidim::User.const_get(:GENDERS).map do |text|
      [
        I18n.t("genders.#{text}", scope: "activemodel.attributes.user"),
        text
      ]
    end
  end

  def districts_for_select
    Decidim::Scope.where(promoted: false).map do |scope|
      [
        translated_attribute(scope.name)
      ]
    end
  end
end
