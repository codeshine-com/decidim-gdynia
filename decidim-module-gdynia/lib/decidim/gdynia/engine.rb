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

      initializer "Gdynia.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
