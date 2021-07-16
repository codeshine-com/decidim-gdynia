# frozen_string_literal: true

module Decidim
  module Core
    module Extended
      module Admin
        # Controller that allows managing all the attachment collections for an static pages.
        #
        class AttachmentCollectionsController < Decidim::Core::Extended::Admin::ApplicationController
          include Decidim::Admin::Concerns::HasAttachmentCollections

          def after_destroy_path
            static_page_attachment_collections_path(static_page)
          end

          def collection_for
            static_page
          end

          def static_page
            @static_page ||= static_pages.find_by(slug: params[:static_page_id])
          end
        end
      end
    end
  end
end
