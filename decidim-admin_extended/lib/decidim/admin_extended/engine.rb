# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module AdminExtended
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::AdminExtended

      routes do
        scope "/admin" do
          resources :informations, controller: 'admin/informations'
        end
      end

      initializer "decidim_admin_extended.append_routes", after: :load_config_initializers do |_app|
        Rails.application.routes.append do
          mount Decidim::AdminExtended::Engine => "/"
        end
      end

      # initializer "decidim_admin_extended.assets.precompile" do |app|
      #   app.config.assets.precompile += %w(decidim/admin_extended/admin_quill_custom.css)
      #   app.config.assets.precompile += %w(decidim/admin_extended/admin_styles.css)
      # end
      #
      # make decorators autoload in development env
      config.autoload_paths << File.join(
        Decidim::AdminExtended::Engine.root, "app", "decorators", "{**}"
      )

      # make decorators available to applications that use this Engine
      config.to_prepare do
        Dir.glob(Decidim::AdminExtended::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
          require_dependency(c)
        end
      end

      initializer "decidim_admin_extended.add_cells_view_paths" do
  	    Cell::ViewModel.view_paths << File.expand_path("#{Decidim::AdminExtended::Engine.root}/app/cells")
      end

      # informations - can be moved to different engine
      initializer "decidim_admin_extended.content_blocks" do
        Decidim.content_blocks.register(:homepage, :latest_informations) do |content_block|
          content_block.cell = "decidim/admin_extended/content_blocks/latest_informations"
          content_block.public_name_key = "decidim.admin_extended.content_blocks.latest_informations.name"
          content_block.default!
        end
      end

      initializer "decidim_admin.menu" do
        Decidim.menu :admin_menu do |menu|
          menu.item I18n.t("menu.informations", scope: "decidim.admin"),
                    decidim_admin_extended.informations_path,
                    icon_name: "info",
                    position: 4.6,
                    active: [%w(decidim/admin/informations decidim/admin_extened/admin/informations decidim/admin_extened/informations), []],
                    if: allowed_to?(:update, :organization, organization: current_organization)
        end
      end


      initializer "admin_extended.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
