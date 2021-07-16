# frozen_string_literal: true

module Decidim
  module PagesExtended
    module Admin
      # Controller that allows managing all the attachment collections for an static pages.
      #
      class AttachmentCollectionsController < Decidim::PagesExtended::Admin::ApplicationController
        include Decidim::Admin::Concerns::HasAttachmentCollections

        def after_destroy_path
          page_attachment_collections_path(page)
        end

        def collection_for
          page
        end

        def page
          @page ||= pages.find(params[:page_id])
        end
      end
    end
  end
end
