# frozen_string_literal: true

Decidim::ParticipatoryProcesses::Admin::ParticipatoryProcessForm.class_eval do
  attribute :contact_address, String
  attribute :contact_email, String
  attribute :contact_phone, String
  attribute :facebook_handler, String
end

