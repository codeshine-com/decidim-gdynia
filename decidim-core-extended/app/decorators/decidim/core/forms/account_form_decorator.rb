# frozen_string_literal: true

Decidim::AccountForm .class_eval do
  include Decidim::TranslationsHelper

  attribute :gender
  attribute :birth_year
  attribute :district

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
