module Decidim
  module ProposalsExtended
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::ProposalsExtended

      Decidim.find_component_manifest('proposals').settings(:global) do |settings|
        settings.attribute :private_proposal, type: :boolean, default: false
        settings.attribute :transparent, type: :boolean, default: true
      end

      config.autoload_paths << File.join(
        Decidim::ProposalsExtended::Engine.root, "app", "decorators", "{**}"
      )

      # make decorators available to applications that use this Engine
      config.to_prepare do
        Dir.glob(Decidim::ProposalsExtended::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
          require_dependency(c)
        end
      end
    end
  end
end
