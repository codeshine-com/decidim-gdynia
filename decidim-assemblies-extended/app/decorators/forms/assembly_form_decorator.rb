# frozen_string_literal: true

Decidim::Assemblies::Admin::AssemblyForm.class_eval do
  CREATED_BY = %w(city_council city_mayor others).freeze
  DURATION_TEXT = %w(indefinitely until_further_notice).freeze

  attribute :contact_address, String
  attribute :duration_text, String
  attribute :team_service, String
  attribute :next_meeting_date, Decidim::Attributes::LocalizedDate

  validates :subtitle, presence: true, if: proc{ |a| false }
  _validators.reject! { |key, _| key == :subtitle }
  _validators.each do |key, _|
    _[0].attributes.delete(:subtitle) if _[0].attributes.include?(:subtitle)
  end

  def duration_text_for_select
    DURATION_TEXT.map do |text|
      [
        I18n.t("duration_text.#{text}", scope: "decidim.assemblies"),
        text
      ]
    end
  end

  def created_by_for_select
    CREATED_BY.map do |creator|
      [
        I18n.t("created_by.#{creator}", scope: "decidim.assemblies"),
        creator
      ]
    end
  end
end
