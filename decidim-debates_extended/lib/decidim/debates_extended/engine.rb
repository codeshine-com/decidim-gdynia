# frozen_string_literal: true

module Decidim
  module DebatesExtended
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::DebatesExtended

      initializer "decidim_processes_extended.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::DebatesExtended::Engine.root}/app/cells")
      end

      # make decorators autoload in development env
      config.autoload_paths << File.join(
        Decidim::DebatesExtended::Engine.root, "app", "decorators", "{**}"
      )

      # make decorators available to applications that use this Engine
      config.to_prepare do
        Dir.glob(Decidim::DebatesExtended::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
          require_dependency(c)
        end
      end
    end
  end
end
