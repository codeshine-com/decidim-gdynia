module Decidim
  module PagesExtended
    module Admin
      class ApplicationController < Decidim::Admin::ApplicationController
        protect_from_forgery with: :exception

        helper_method :pages, :page, :current_participatory_space

        layout 'decidim/pages_extended/admin/back_to_space'

        def pages
          @pages ||= Decidim::Pages::Page.all
        end

        def page
          @page ||= pages.find_by(slug: params[:page_id])
        end

        def current_participatory_space
          @current_participatory_space ||= page.participatory_space
        end
      end
    end
  end
end
