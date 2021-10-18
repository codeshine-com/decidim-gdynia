# frozen_string_literal: true

module Decidim
  module PagesExtended
    module Admin
      # Controller that allows managing all the attachments for a static
      # page.
      #
      class AttachmentsController < Decidim::PagesExtended::Admin::ApplicationController
        include Decidim::Admin::Concerns::HasAttachments

        def index
          enforce_permission_to :update, :page_extended, page: page

          render template: "decidim/pages_extended/admin/attachments/index"
        end

        def new
          enforce_permission_to :update, :page_extended, page: page
          @form = form(::Decidim::Admin::AttachmentForm).from_params({}, attached_to: attached_to)
          render template: "decidim/admin/attachments/new"
        end

        def create
          enforce_permission_to :update, :page_extended, page: page
          @form = form(::Decidim::Admin::AttachmentForm).from_params(params, attached_to: attached_to)

          Decidim::Admin::CreateAttachment.call(@form, attached_to) do
            on(:ok) do
              flash[:notice] = I18n.t("attachments.create.success", scope: "decidim.admin")
              redirect_to action: :index
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("attachments.create.error", scope: "decidim.admin")
              render template: "decidim/admin/attachments/new"
            end
          end
        end

        def edit
          @attachment = collection.find(params[:id])
          enforce_permission_to :update, :page_extended, page: page
          @form = form(::Decidim::Admin::AttachmentForm).from_model(@attachment, attached_to: attached_to)
          render template: "decidim/admin/attachments/edit"
        end

        def update
          @attachment = collection.find(params[:id])
          enforce_permission_to :update, :page_extended, page: page
          @form = form(::Decidim::Admin::AttachmentForm).from_params(attachment_params, attached_to: attached_to)

          Decidim::Admin::UpdateAttachment.call(@attachment, @form) do
            on(:ok) do
              flash[:notice] = I18n.t("attachments.update.success", scope: "decidim.admin")
              redirect_to action: :index
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("attachments.update.error", scope: "decidim.admin")
              render template: "decidim/admin/attachments/edit"
            end
          end
        end

        def show
          @attachment = collection.find(params[:id])
          enforce_permission_to :read, :attachment, attachment: attachment
          render template: "decidim/admin/attachments/show"
        end

        def destroy
          @attachment = collection.find(params[:id])
          enforce_permission_to :update, :page_extended, page: page
          @attachment.destroy!

          flash[:notice] = I18n.t("attachments.destroy.success", scope: "decidim.admin")

          redirect_to after_destroy_path
        end

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
