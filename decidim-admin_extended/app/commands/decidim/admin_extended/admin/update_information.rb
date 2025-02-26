# frozen_string_literal: true

module Decidim
  module AdminExtended
    module Admin
      # This command is executed when user updates Information
      class UpdateInformation < Decidim::Command
        def initialize(information, form)
          @form = form
          @information = information
        end

        # Creates the information if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if form.invalid?

          update_information!

          broadcast(:ok, information)
        end

        private

        attr_reader :information, :form

        def update_information!
          Decidim.traceability.update!(
            information,
            form.current_user,
            information_params,
            visibility: "admin-only"
          )
        end

        def information_params
          {
            name: form.name,
            body: form.body,
            lead: form.lead,
            link_url: form.link_url,
            published: form.published,
          }
        end
      end
    end
  end
end
