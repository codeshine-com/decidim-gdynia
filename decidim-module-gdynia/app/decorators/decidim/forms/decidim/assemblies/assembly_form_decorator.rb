# frozen_string_literal: true

Decidim::Assemblies::Admin::AssemblyForm.class_eval do
  clear_validators!

  validates :parent, presence: true, if: ->(form) { form.parent.present? }
  validate :ensure_parent_cannot_be_child, if: ->(form) { form.parent.present? }

  validates :slug, presence: true, format: { with: Decidim::Assembly.slug_format }

  validate :slug_uniqueness

  validates :created_by_other, translatable_presence: true, if: ->(form) { form.created_by == "others" }
  validates :title, :description, :short_description, translatable_presence: true

  validates :banner_image, passthru: { to: Decidim::Assembly }
  validates :hero_image, passthru: { to: Decidim::Assembly }

  validates :weight, presence: true

  attribute :contact_address, String
  attribute :contact_email, String
  attribute :contact_phone, String
  attribute :team_service, String
end
