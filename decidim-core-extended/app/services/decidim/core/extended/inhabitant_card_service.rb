# frozen_string_literal: true

module Decidim
  module Core
    module Extended
      class InhabitantCardService

        def initialize()
          @user = user
          @action = action.to_s if action
          @component = resource.try(:component) || component
          @resource = resource
        end

      end
    end
  end
end
