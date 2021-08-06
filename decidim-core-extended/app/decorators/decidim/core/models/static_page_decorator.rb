# frozen_string_literal: true

Decidim::StaticPage.class_eval do
  include Decidim::HasAttachments
  include Decidim::HasAttachmentCollections

end
