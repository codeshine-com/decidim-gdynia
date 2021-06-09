module Decidim
  module Core
    module Extended
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::Core::Extended

        initializer "decidim.user_menu" do
          Decidim.menu :user_menu do |menu|
            menu.item t("change_password", scope: "layouts.decidim.user_profile"),
                      decidim.account_path(pass: true),
                      position: 998,
                      active: :exact
          end
        end

        initializer "decidim_core_extended.assets.precompile" do |app|
          app.config.assets.precompile += %w(decidim/core/extended/Logotypy_UE.png)
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
