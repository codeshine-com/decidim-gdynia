# frozen_string_literal: true

module Decidim
  module AdminExtended
    module Admin
      class ApplicationController < Decidim::Admin::ApplicationController
        helper Decidim::ApplicationHelper
        helper_method :informations, :information, :dummy_information, :dummy_information_two

        # layout "decidim/admin/news/informations"

        def informations
          @informations ||= Information.where(decidim_organization_id: current_organization.id).order(created_at: :desc).page(params[:page]).per(15)
        end

        def information
          @information ||= informations.find(params[:id]) if params[:id]
        end

        def dummy_information
          @dummy_information ||= Decidim::AdminExtended::Information.new(
                                  name: 'Informacja z większą ilością tekstu',
                                  body: 'Treść informacji, tutaj moze wystąpić różna ilość tekstu, np. bardzo duzo <span style="color: red; font-weight: bold">Lorem ipsum</span> dolor sit amet,
                                        consectetur adipiscing elit. Proin tristique rhoncus risus. Aenean vel condimentum mi.',
                                  lead: 'Dołącz do procesu!'
                                  )
        end

        def dummy_information_two
          @dummy_information_two ||= Decidim::AdminExtended::Information.new(
                                  name: 'Informacja z linkiem',
                                  body: 'Treść informacji, tutaj moze wystąpić różna ilość tekstu, np. <strong>bardzo mało...</strong>',
                                  lead: 'Kliknij mnie!',
                                  link_url: '#'
                                  )
        end
      end
    end
  end
end
