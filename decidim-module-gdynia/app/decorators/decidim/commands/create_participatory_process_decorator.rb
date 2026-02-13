# frozen_string_literal: true

Decidim::ParticipatoryProcesses::Admin::CreateParticipatoryProcess.class_eval do
  fetch_form_attributes :organization, :title, :subtitle, :weight, :slug, :hashtag, :description,
                        :short_description, :promoted, :taxonomizations, :announcement,
                        :private_space, :developer_group, :local_area, :target,
                        :participatory_scope, :participatory_structure, :meta_scope, :start_date, :end_date,
                        :participatory_process_group,:contact_address,:contact_email,:contact_phone,:facebook_handler
end
