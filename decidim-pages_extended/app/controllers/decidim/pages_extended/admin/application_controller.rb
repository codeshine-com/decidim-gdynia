module Decidim
  module PagesExtended
    module Admin
      class ApplicationController < Decidim::Admin::ApplicationController
        protect_from_forgery with: :exception

        helper_method :pages, :page

        def pages
          @pages ||= Decidim::Pages::Page.all
        end

        def page
          @page ||= pages.find_by(slug: params[:page_id])
        end
      end
    end
  end
end
