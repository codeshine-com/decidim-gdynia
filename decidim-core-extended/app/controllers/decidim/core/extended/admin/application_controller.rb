module Decidim
  module Core
    module Extended
      module Admin
        class ApplicationController < Decidim::Admin::ApplicationController
          protect_from_forgery with: :exception

          helper_method :static_pages, :static_page

          def static_pages
            @static_pages ||= Decidim::StaticPage.all
          end

          def static_page
            @static_page ||= static_pages.find_by(slug: params[:static_page_id])
          end
        end
      end
    end
  end
end
