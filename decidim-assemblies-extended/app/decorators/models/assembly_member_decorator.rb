# frozen_string_literal: true

module Decidim
  AssemblyMember.class_eval do
    include Decidim::HasUploadValidations

    delegate :organization, to: :assembly, allow_nil: true

    # mount_uploader :avatar, Decidim::Cw::AvatarUploader
    has_one_attached :avatar
    validates_upload :avatar, uploader: Decidim::AvatarUploader

    belongs_to :cadency, foreign_key: "decidim_assemblies_extended_cadency_id", class_name: "Decidim::Assemblies::Extended::Cadency", optional: true

    def avatar_big
      avatar.variant(resize_to_fit: [80, 80])
    end
  end
end
