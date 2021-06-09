# frozen_string_literal: true

Decidim::Assemblies::Admin::AssemblyMemberForm.class_eval do
  include Decidim::HasUploadValidations

  attribute :affiliation, String
  attribute :representation, String

  attribute :avatar
  # attribute :remove_avatar

  validates :avatar, passthru: { to: Decidim::AssemblyMember }
end
