require_dependency "decidim/assemblies/application_controller"
require_dependency "decidim/assemblies/extended/application_controller"
require_dependency "decidim/assemblies/admin/application_controller"

module Decidim::Assemblies::Extended
  class Admin::CadenciesController < Decidim::Assemblies::Admin::ApplicationController
    include Rails.application.routes.mounted_helpers
    layout "decidim/admin/assembly"
    helper_method :current_assembly
    helper_method :current_participatory_space

    def index
      enforce_permission_to :index, :assembly_member

      @assembly_cadencies = collection
    end

    def new
      enforce_permission_to :create, :assembly_member
      @form = form(Decidim::Assemblies::Extended::CadencyForm).instance
    end

    def create
      enforce_permission_to :create, :assembly_member
      @form = form(Decidim::Assemblies::Extended::CadencyForm).from_params(params)

      Decidim::Assemblies::Extended::Admin::CreateCadency.call(@form, current_user, current_assembly) do
        on(:ok) do
          flash[:notice] = I18n.t("cadencies.create.success", scope: "decidim.admin")
          redirect_to cadencies_path(current_assembly)
        end

        on(:invalid) do
          flash[:alert] = I18n.t("cadencies.create.error", scope: "decidim.admin")
          render :new
        end
      end
    end

    def edit
      @cadency = collection.find(params[:id])
      enforce_permission_to :update, :assembly_member, member: @cadency
      @form = form(Decidim::Assemblies::Extended::CadencyForm).from_model(@cadency)
    end

    def update
      @cadency = collection.find(params[:id])
      enforce_permission_to :update, :assembly_member, member: @cadency
      @form = form(Decidim::Assemblies::Extended::CadencyForm).from_params(params)

      Decidim::Assemblies::Extended::Admin::UpdateCadency.call(@form, current_user, @cadency) do
        on(:ok) do
          flash[:notice] = I18n.t("cadencies.update.success", scope: "decidim.admin")
          redirect_to cadencies_path(current_assembly)
        end

        on(:invalid) do
          flash.now[:alert] = I18n.t("cadencies.update.error", scope: "decidim.admin")
          render :edit
        end
      end
    end

    def destroy
      @cadency = collection.find(params[:id])
      enforce_permission_to :destroy, :assembly_member, member: @cadency

      Decidim::Assemblies::Extended::Admin::DestroyCadency.call(@cadency, current_user) do
        on(:ok) do
          flash[:notice] = I18n.t("cadencies.destroy.success", scope: "decidim.admin")
          redirect_to cadencies_path(current_assembly)
        end
      end
    end

    private

    def collection
      @collection ||= Decidim::Assemblies::Extended::Cadency.where(assembly: current_assembly).order('weight DESC')
    end

    def current_assembly
      @current_assembly ||= Decidim::Assembly.where(slug: params[:assembly_slug]).or(
        Decidim::Assembly.where(id: params[:assembly_slug])
      ).first
    end

    alias current_participatory_space current_assembly
  end
end
