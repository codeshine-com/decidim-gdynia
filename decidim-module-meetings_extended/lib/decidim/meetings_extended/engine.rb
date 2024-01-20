# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module MeetingsExtended
    # This is the engine that runs on the public interface of meetings_extended.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::MeetingsExtended

      routes do
        # Add engine routes here
        # resources :meetings_extended
        # root to: "meetings_extended#index"
      end

      # initializer "decidim_meetings_extended.assets" do |app|
      #   app.config.assets.precompile += %w[decidim_meetings_extended_manifest.js decidim_meetings_extended_manifest.css]
      # end

      # make decorators autoload in development env
      config.autoload_paths << File.join(
        Decidim::MeetingsExtended::Engine.root, "app", "decorators", "{**}"
      )

      # make decorators available to applications that use this Engine
      config.to_prepare do
        Dir.glob(Decidim::MeetingsExtended::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
          require_dependency(c)
        end
      end
    end
  end
end
