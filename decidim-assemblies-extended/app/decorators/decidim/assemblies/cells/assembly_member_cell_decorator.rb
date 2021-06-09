# frozen_string_literal: true

module Decidim
  module Assemblies::Extended
    class AssemblyMemberCell < Decidim::Assemblies::AssemblyMemberCell
      property :affiliation
      property :representation
      property :ceased_date
    end
  end
end
