# frozen_string_literal: true

module Decidim
  module Processes
    module Extended
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::Processes::Extended

        # initializer "decidim_processes_extended.assets.precompile" do |app|
        #   app.config.assets.precompile += %w(decidim/processes/extended/dates.js)
        # end

        initializer "decidim_processes_extended.add_cells_view_paths" do
	         Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Processes::Extended::Engine.root}/app/cells")
      	end

        # make decorators autoload in development env
        config.autoload_paths << File.join(
          Decidim::Processes::Extended::Engine.root, "app", "decorators", "{**}"
        )

        # make decorators available to applications that use this Engine
        config.to_prepare do
          Dir.glob(Decidim::Processes::Extended::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
            require_dependency(c)
          end
        end

        initializer "decidim_processes_extended.webpacker.assets_path" do
          Decidim.register_assets_path File.expand_path("app/packs", root)
        end
      end
    end
  end
end
