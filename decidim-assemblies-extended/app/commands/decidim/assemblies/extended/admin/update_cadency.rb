# frozen_string_literal: true

module Decidim
  module Assemblies::Extended
    module Admin
      # A command with all the business logic when updating a new cadency
      # type in the system.
      class UpdateCadency < Decidim::Command
        # Public: Initializes the command.
        #
        # form - A form object with the params.
        def initialize(form, current_user, cadency)
          @form = form
          @current_user = current_user
          @cadency = cadency
        end

        # Executes the command. Broadcasts these events:
        #
        # - :ok when everything is valid.
        # - :invalid if the form wasn't valid and we couldn't proceed.
        #
        # Returns nothing.
        def call
          return broadcast(:invalid) if form.invalid?
          return broadcast(:invalid) unless cadency

          update_cadency!
          broadcast(:ok)
        end

        private

        attr_reader :form, :cadency, :current_user

        def update_cadency!
          log_info = {
            resource: {
              title: cadency.name
            },
            participatory_space: {
              title: cadency.assembly.title
            }
          }

          Decidim.traceability.update!(
            cadency,
            current_user,
            form.attributes.slice(
              :name,
              :weight
            ),
            log_info
          )
        end
      end
    end
  end
end
