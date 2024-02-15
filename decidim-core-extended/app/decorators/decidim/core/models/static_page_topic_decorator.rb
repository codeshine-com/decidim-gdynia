# frozen_string_literal: true

Decidim::StaticPageTopic.class_eval do

  # mount_uploader :cover, Decidim::Cw::BannerImageUploader
  has_one_attached :cover
end
