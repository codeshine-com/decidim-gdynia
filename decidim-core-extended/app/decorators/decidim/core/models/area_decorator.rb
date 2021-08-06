# frozen_string_literal: true

Decidim::Area.class_eval do

  mount_uploader :icon, Decidim::ImageUploader

end
