# frozen_string_literal: true

module Decidim
  module Core
    module Extended
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::Core::Extended

        unsearchable_resources_manifest_names = [
          'initiative', 'conference', 'consultation', 'voting',
          'budget'
        ]
        unsearchable_resources_manifest_names.each do |manifest_name|
          resourcable = Decidim.find_resource_manifest(manifest_name)
          resourcable.searchable = false if resourcable
        end

        initializer "decidim.user_menu" do
          Decidim.menu :user_menu do |menu|
            menu.item t("change_password", scope: "layouts.decidim.user_profile"),
                      decidim.account_path(pass: true),
                      position: 998,
                      active: :exact
          end
          Decidim.menu :user_menu do |menu|
            menu.item t("inhabitant_card_authorization", scope: "layouts.decidim.user_profile"),
                      decidim_core_extended.inhabitant_cards_path,
                      position: 1.05,
                      active: :exact
          end
        end

        routes do
          resources :groups, only: :destroy, controller: "groups" do
            member do
              get 'delete', action: :delete, as: :delete
            end
          end
          resource :inhabitant_cards, only: [:show, :create], controller: 'authorizations'

          resources :static_pages, only: [] do
            resources :attachment_collections, controller: 'admin/attachment_collections'
            resources :attachments, controller: 'admin/attachments'
          end
        end

        initializer "decidim_core_extended.append_routes", after: :load_config_initializers do |_app|
          Rails.application.routes.append do
            mount Decidim::Core::Extended::Engine => "/"
          end
        end

        initializer "decidim_core_extended.assets.precompile" do |app|
          app.config.assets.precompile += %w(decidim/core/extended/Logotypy_UE.png)
          app.config.assets.precompile += %w(decidim/core/extended/O_platformie_pasek.png)
          app.config.assets.precompile += %w(decidim/core/extended/email.scss)
          app.config.assets.precompile += %w(decidim/core/extended/registration_types_handler.js)
        end

        initializer "decidim_core_extended.add_cells_view_paths" do
          Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Core::Extended::Engine.root}/app/cells")
        end

        # make decorators autoload in development env
        config.autoload_paths << File.join(
          Decidim::Core::Extended::Engine.root, "app", "decorators", "{**}"
        )

        # make decorators available to applications that use this Engine
        config.to_prepare do
          Dir.glob(Decidim::Core::Extended::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
            require_dependency(c)
          end
        end
      end
    end
  end
end
