# frozen_string_literal: true

module Decidim
  module AdminExtended
    module ContentBlocks
      class LatestInformationsCell < Decidim::ViewModel
        include Decidim::CardHelper

        def show
          return if latest_informations.blank?

          render :show
        end

        def latest_informations
          @latest_informations ||= Decidim::AdminExtended::Information
                               .where(organization: current_organization)
                               .where(published: true)
                               .order(created_at: :desc)
                               .limit(limit)
        end

        private

        def limit
          3
        end
      end
    end
  end
end
