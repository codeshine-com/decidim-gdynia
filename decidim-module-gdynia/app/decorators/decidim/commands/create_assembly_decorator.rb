# frozen_string_literal: true

Decidim::Assemblies::Admin::CreateAssembly.class_eval do
  fetch_file_attributes :hero_image, :banner_image

  fetch_form_attributes :title, :subtitle, :weight, :slug, :hashtag, :description, :short_description,
                        :promoted, :taxonomizations, :parent, :announcement, :organization,
                        :private_space, :developer_group, :local_area, :target, :participatory_scope,
                        :participatory_structure, :meta_scope, :purpose_of_action,
                        :composition, :creation_date, :created_by, :created_by_other,
                        :duration, :included_at, :closing_date, :closing_date_reason, :internal_organisation,
                        :is_transparent, :special_features, :twitter_handler, :facebook_handler,
                        :instagram_handler, :youtube_handler, :github_handler,
                        :contact_address, :contact_email, :contact_phone, :team_service
end
