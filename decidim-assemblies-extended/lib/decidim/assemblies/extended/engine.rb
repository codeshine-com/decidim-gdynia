module Decidim
  module Assemblies
    module Extended
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::Assemblies::Extended

        initializer "decidim_processes_extended.assets.precompile" do |app|
          app.config.assets.precompile += %w(decidim/assemblies/admin/custom.js)
        end

        # needs to be removed for generating new migrations
        # make decorators autoload in development env
        config.autoload_paths << File.join(
          Decidim::Assemblies::Extended::Engine.root, "app", "decorators", "{**}"
        )

        initializer "decidim_processes_extended.add_cells_view_paths" do
          Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Assemblies::Extended::Engine.root}/app/cells")
        end

        # make decorators available to applications that use this Engine
        config.to_prepare do
          Dir.glob(Decidim::Assemblies::Extended::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
            require_dependency(c)
          end

          Dir.glob(Decidim::Assemblies::Extended::Engine.root + "app/models/**/*_decorator*.rb").each do |c|
            require_dependency(c)
          end
        end
      end
    end
  end
end
