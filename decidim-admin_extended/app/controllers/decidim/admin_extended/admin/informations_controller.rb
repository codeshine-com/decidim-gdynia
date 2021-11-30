# frozen_string_literal: true

# require_dependency "decidim/news/application_controller"

module Decidim::AdminExtended
  class Admin::InformationsController < Decidim::AdminExtended::Admin::ApplicationController
    helper Decidim::ApplicationHelper
    # helper Decidim::CellsHelper
    helper Decidim::CardHelper
    # layout "decidim/admin/informations"

    def index
      enforce_permission_to :update, :organization, organization: current_organization
      @informations = collection.page(params[:page]).per(15)
    end

    # def show
    #   enforce_permission_to :update, :organization, organization: current_organization
    #   # information
    # end

    def new
      enforce_permission_to :update, :organization, organization: current_organization
      @form = form(Decidim::AdminExtended::Admin::InformationForm).instance
    end

    def create
      enforce_permission_to :update, :organization, organization: current_organization
      @form = form(Decidim::AdminExtended::Admin::InformationForm).from_params(params)

      Decidim::AdminExtended::Admin::CreateInformation.call(@form) do
        on(:ok) do
          flash[:notice] = I18n.t("informations.create.success", scope: "decidim.admin")
          redirect_to informations_path
        end

        on(:invalid) do
          flash.now[:alert] = I18n.t("informations.create.error", scope: "decidim.admin")
          render :new
        end
      end
    end

    def edit
      enforce_permission_to :update, :organization, organization: current_organization
      @form = form(Decidim::AdminExtended::Admin::InformationForm).from_model(information)
    end

    def update
      @information = collection.find(params[:id])
      enforce_permission_to :update, :organization, organization: current_organization
      @form = form(Decidim::AdminExtended::Admin::InformationForm).from_params(params)

      Decidim::AdminExtended::Admin::UpdateInformation.call(information, @form) do
        on(:ok) do
          flash[:notice] = I18n.t("informations.update.success", scope: "decidim.admin")
          redirect_to informations_path
        end

        on(:invalid) do
          flash.now[:alert] = I18n.t("informations.update.error", scope: "decidim.admin")
          render :edit
        end
      end
    end

    # def destroy
    #   enforce_permission_to :update, :organization
    #
    #   Decidim::AdminExtended::Admin::DestroyInformation.call(information, current_user) do
    #     on(:ok) do
    #       flash[:notice] = I18n.t("informations.destroy.success", scope: "decidim.admin")
    #       redirect_to informations_path
    #     end
    #   end
    # end

    private

    def information
      @information ||= collection.find_by(id: params[:id])
    end

    def collection
      Information.where(decidim_organization_id: current_organization.id)
      # current_organization.informations
    end
  end
end
