# frozen_string_literal: true

module Decidim
  AssemblyMember.class_eval do
    delegate :organization, to: :assembly, allow_nil: true

    mount_uploader :avatar, Decidim::AvatarUploader

    belongs_to :cadency, foreign_key: "decidim_assemblies_extended_cadency_id", class_name: "Decidim::Assemblies::Extended::Cadency", optional: true
  end
end
