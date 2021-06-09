module Decidim
  module Assemblies
    module Extended
      class ApplicationController < ActionController::Base
        protect_from_forgery with: :exception
      end
    end
  end
end
