# frozen_string_literal: true

module Decidim
  module AdminExtended
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::AdminExtended

      initializer "decidim_admin_extended.assets.precompile" do |app|
        app.config.assets.precompile += %w(decidim/admin_extended/admin_quill_custom.css)
        app.config.assets.precompile += %w(decidim/admin_extended/admin_styles.css)
      end

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
    end
  end
end
