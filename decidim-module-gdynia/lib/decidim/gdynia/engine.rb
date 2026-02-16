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


      initializer "Gdynia.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
