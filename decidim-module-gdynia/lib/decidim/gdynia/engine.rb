# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Gdynia
    # This is the engine that runs on the public interface of gdynia.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Gdynia

      routes do
        # Add engine routes here
        # resources :gdynia
        # root to: "gdynia#index"

        resource :inhabitant_cards, only: [:show, :create], controller: "authorizations"
      end

      initializer "decidim_gdynia.append_routes", after: :load_config_initializers do |_app|
        Rails.application.routes.append do
          mount Decidim::Gdynia::Engine => "/"
        end
      end

      initializer "decidim.user_menu" do
        Decidim.menu :user_menu do |menu|
          menu.item t("inhabitant_card_authorization", scope: "layouts.decidim.user_profile"),
                    decidim_gdynia.inhabitant_cards_path,
                    position: 1.05,
                    active: :exact
        end
      end

      config.autoload_paths << File.join(
        Decidim::Gdynia::Engine.root, "app", "decorators", "{**}"
      )

      # make decorators available to applications that use this Engine
      config.to_prepare do
        Dir.glob(Decidim::Gdynia::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
          load c
        end
      end

      initializer "decidim_gdynia.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Gdynia::Engine.root}/app/cells")
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Gdynia::Engine.root}/app/views") # for partials
      end

      initializer "decidim_gdynia.register_icons" do
        Decidim.icons.register(name: "facebook-line", icon: "facebook-line", category: "system", description: "", engine: :core)
        Decidim.icons.register(name: "loop-right-fill", icon: "loop-right-fill", category: "system", description: "", engine: :core)
        Decidim.icons.register(name: "verified-badge-line", icon: "verified-badge-line", category: "system", description: "", engine: :core)
      end


      initializer "Gdynia.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
