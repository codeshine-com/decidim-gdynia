module Decidim
  module Assemblies
    module Extended
      class ApplicationController < Decidim::ApplicationController
        protect_from_forgery with: :exception
      end
    end
  end
end
