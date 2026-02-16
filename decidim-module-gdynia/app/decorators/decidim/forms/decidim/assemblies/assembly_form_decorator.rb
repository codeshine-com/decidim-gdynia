# frozen_string_literal: true

Decidim::Assemblies::Admin::AssemblyForm.class_eval do
  attribute :contact_address, String
  attribute :contact_email, String
  attribute :contact_phone, String
  attribute :team_service, String
end
