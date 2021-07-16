# frozen_string_literal: true

module Decidim
  module SurveysExtended
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::SurveysExtended

      Decidim.find_component_manifest('surveys').settings(:global) do |settings|
        settings.attribute :private_survey, type: :boolean, default: false
        settings.attribute :transparent, type: :boolean, default: true
      end

      config.autoload_paths << File.join(
        Decidim::SurveysExtended::Engine.root, "app", "decorators", "{**}"
      )

      # make decorators available to applications that use this Engine
      config.to_prepare do
        Dir.glob(Decidim::SurveysExtended::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
          require_dependency(c)
        end
      end
    end
  end
end
