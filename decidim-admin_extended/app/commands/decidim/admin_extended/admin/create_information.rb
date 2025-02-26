# frozen_string_literal: true

module Decidim
  module AdminExtended
    module Admin
      # This command is executed when user creates Information
      class CreateInformation < Decidim::Command
        def initialize(form)
          @form = form
        end

        # Creates the information if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if form.invalid?

          create_information!

          broadcast(:ok, information)
        end

        private

        attr_reader :information, :form

        def create_information!
          @information = Decidim.traceability.create!(
            Decidim::AdminExtended::Information,
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
            organization: form.current_organization
          }
        end
      end
    end
  end
end
