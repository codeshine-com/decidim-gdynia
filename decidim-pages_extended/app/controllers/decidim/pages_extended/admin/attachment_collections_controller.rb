# frozen_string_literal: true

module Decidim
  module PagesExtended
    module Admin
      # Controller that allows managing all the attachment collections for an static pages.
      #
      class AttachmentCollectionsController < Decidim::PagesExtended::Admin::ApplicationController
        include Decidim::Admin::Concerns::HasAttachmentCollections

        def index
          enforce_permission_to :update, :page_extended, page: page

          render template: "decidim/pages_extended/admin/attachment_collections/index"
        end

        def new
          enforce_permission_to :update, :page_extended, page: page
          @form = form(Decidim::Admin::AttachmentCollectionForm).from_params({}, collection_for: collection_for)
          render template: "decidim/admin/attachment_collections/new"
        end

        def create
          enforce_permission_to :update, :page_extended, page: page
          @form = form(Decidim::Admin::AttachmentCollectionForm).from_params(params, collection_for: collection_for)

          Decidim::Admin::CreateAttachmentCollection.call(@form, collection_for) do
            on(:ok) do
              flash[:notice] = I18n.t("attachment_collections.create.success", scope: "decidim.admin")
              redirect_to action: :index
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("attachment_collections.create.error", scope: "decidim.admin")
              render template: "decidim/admin/attachment_collections/new"
            end
          end
        end

        def edit
          @attachment_collection = collection.find(params[:id])
          enforce_permission_to :update, :page_extended, page: page
          @form = form(Decidim::Admin::AttachmentCollectionForm).from_model(@attachment_collection, collection_for: collection_for)
          render template: "decidim/admin/attachment_collections/edit"
        end

        def update
          @attachment_collection = collection.find(params[:id])
          enforce_permission_to :update, :page_extended, page: page
          @form = form(Decidim::Admin::AttachmentCollectionForm).from_params(params, collection_for: collection_for)

          Decidim::Admin::UpdateAttachmentCollection.call(@attachment_collection, @form) do
            on(:ok) do
              flash[:notice] = I18n.t("attachment_collections.update.success", scope: "decidim.admin")
              redirect_to action: :index
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("attachment_collections.update.error", scope: "decidim.admin")
              render template: "decidim/admin/attachment_collections/edit"
            end
          end
        end

        def show
          @attachment_collection = collection.find(params[:id])
          enforce_permission_to :update, :page_extended, page: page
          render template: "decidim/admin/attachment_collections/show"
        end

        def destroy
          @attachment_collection = collection.find(params[:id])
          enforce_permission_to :update, :page_extended, page: page
          @attachment_collection.destroy!

          flash[:notice] = I18n.t("attachment_collections.destroy.success", scope: "decidim.admin")

          redirect_to after_destroy_path
        end

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
