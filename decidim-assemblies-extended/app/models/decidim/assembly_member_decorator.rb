# frozen_string_literal: true

module Decidim
  AssemblyMember.class_eval do
    delegate :organization, to: :assembly, allow_nil: true

    mount_uploader :avatar, Decidim::AvatarUploader
  end
end