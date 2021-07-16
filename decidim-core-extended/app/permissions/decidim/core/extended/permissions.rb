# frozen_string_literal: true

module Decidim
  module Core
    module Extended
      class Permissions < Decidim::DefaultPermissions
        def permissions

          return permission_action if permission_action.scope != :admin

          allow!
          permission_action
        end
      end
    end
  end
end
