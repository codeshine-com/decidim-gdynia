# frozen_string_literal: true

module Decidim
  module Core
    module Extended
      module Admin
        # Controller that allows managing all the attachments for a static
        # page.
        #
        class AttachmentsController < Decidim::Core::Extended::Admin::ApplicationController
          include Decidim::Admin::Concerns::HasAttachments

          def after_destroy_path
            static_page_attachments_path(static_page)
          end

          def attached_to
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
