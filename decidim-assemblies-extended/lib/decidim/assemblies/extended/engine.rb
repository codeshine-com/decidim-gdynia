# frozen_string_literal: true

require "rails"
require "active_support/all"

# require "decidim/core"
# require "decidim/assemblies/query_extensions"

module Decidim
  module Assemblies
    module Extended
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::Assemblies::Extended

        initializer "decidim_processes_extended.assets.precompile" do |app|
          app.config.assets.precompile += %w(decidim/assemblies/admin/custom.js)
        end

        routes do
          scope "/assemblies/:assembly_slug" do
            resources :cadencies, controller: 'admin/cadencies'
          end
        end

        initializer "decidim_assemblies_extended.append_routes", after: :load_config_initializers do |_app|
          Rails.application.routes.append do
            mount Decidim::Assemblies::Extended::Engine => "/admin", at: '/admin'
          end
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
