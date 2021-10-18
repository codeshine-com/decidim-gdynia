Decidim::Pages::Page.class_eval do

  include Decidim::HasAttachments
  include Decidim::HasAttachmentCollections

  delegate :participatory_space, to: :component

end
