module Decidim
  module PagesExtended
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::PagesExtended

      routes do
        # Decidim.participatory_space_manifests.each do |manifest|
        #   scope "/admin/#{manifest.name}/:participatory_space_id/components/:component_id" do
        #     resources :pages, only: [] do
        #       resources :attachment_collections, controller: 'admin/attachment_collections', as: "#{manifest.name}_attachment_collections"
        #       resources :attachments, controller: 'admin/attachments', as: "#{manifest.name}_attachments"
        #     end
        #   end
        #   # scope "/admin/participatory_processes/:participatory_space_id/components/:component_id" do
        #   #   resources :pages, only: [] do
        #   #     resources :attachment_collections, controller: 'admin/attachment_collections'
        #   #     resources :attachments, controller: 'admin/attachments'
        #   #   end
        #   # end
        # end
        resources :pages, only: [] do
          resources :attachment_collections, controller: 'admin/attachment_collections'
          resources :attachments, controller: 'admin/attachments'
        end
      end

      initializer "decidim_pages_extended.append_routes", after: :load_config_initializers do |_app|
        Rails.application.routes.append do
          mount Decidim::PagesExtended::Engine => "/admin", at: '/admin'
        end
      end

      config.autoload_paths << File.join(
        Decidim::PagesExtended::Engine.root, "app", "decorators", "{**}"
      )

      # make decorators available to applications that use this Engine
      config.to_prepare do
        Dir.glob(Decidim::PagesExtended::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
          require_dependency(c)
        end
      end
    end
  end
end
