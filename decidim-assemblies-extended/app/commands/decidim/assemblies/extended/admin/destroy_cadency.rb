# frozen_string_literal: true

module Decidim
  module Assemblies::Extended
    module Admin
      # A command with all the business logic when updating a new cadency
      # type in the system.
      class DestroyCadency < Rectify::Command
        # Public: Initializes the command.
        #
        # form - A form object with the params.
        def initialize(cadency, current_user)
          @cadency = cadency
          @current_user = current_user
        end

        # Executes the command. Broadcasts these events:
        #
        # - :ok when everything is valid.
        # - :invalid if the form wasn't valid and we couldn't proceed.
        #
        # Returns nothing.
        def call
          return broadcast(:invalid) unless cadency

          destroy_cadency!
          broadcast(:ok)
        end

        private

        attr_reader :cadency, :current_user

        def destroy_cadency!
          log_info = {
            resource: {
              title: cadency.name
            },
            participatory_space: {
              title: cadency.assembly.title
            }
          }

          Decidim.traceability.perform_action!(
            "delete",
            cadency,
            current_user,
            log_info
          ) do
            cadency.destroy!
            cadency
          end
        end
      end
    end
  end
end
