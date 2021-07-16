# frozen_string_literal: true

module Decidim
  module PagesExtended
    module Admin
      # Controller that allows managing all the attachments for a static
      # page.
      #
      class AttachmentsController < Decidim::PagesExtended::Admin::ApplicationController
        include Decidim::Admin::Concerns::HasAttachments

        def after_destroy_path
          page_attachments_path(page)
        end

        def attached_to
          page
        end

        def page
          @page ||= pages.find(params[:page_id])
        end
      end
    end
  end
end
