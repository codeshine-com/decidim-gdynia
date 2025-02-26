# frozen_string_literal: true

module Decidim
  module Assemblies::Extended
    module Admin
      # A command with all the business logic when creating a new assembly
      # member in the system.
      class CreateCadency < Decidim::Command
        # Public: Initializes the command.
        #
        # form - A form object with the params.
        # assembly - The Assembly that will hold the member
        def initialize(form, current_user, assembly)
          @form = form
          @current_user = current_user
          @assembly = assembly
        end

        # Executes the command. Broadcasts these events:
        #
        # - :ok when everything is valid.
        # - :invalid if the form wasn't valid and we couldn't proceed.
        #
        # Returns nothing.
        def call
          return broadcast(:invalid) if form.invalid?

          create_cadency!
          broadcast(:ok)
        end

        private

        attr_reader :form, :assembly, :current_user

        def create_cadency!
          log_info = {
            resource: {
              title: form.name
            },
            participatory_space: {
              title: assembly.title
            }
          }

          @cadency = Decidim.traceability.create!(
            Decidim::Assemblies::Extended::Cadency,
            current_user,
            form.attributes.slice(
              :name,
              :weight
            ).merge(
              assembly: assembly
            ),
            log_info
          )
        end
      end
    end
  end
end
