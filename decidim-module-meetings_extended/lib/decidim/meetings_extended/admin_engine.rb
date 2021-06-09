# frozen_string_literal: true

module Decidim
  module MeetingsExtended
    # This is the engine that runs on the public interface of `MeetingsExtended`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::MeetingsExtended::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :meetings_extended do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "meetings_extended#index"
      end

      def load_seed
        nil
      end
    end
  end
end
