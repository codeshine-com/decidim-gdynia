module Decidim::Assemblies::Extended
  class Cadency < ::ApplicationRecord
    include Decidim::Loggable
    include Decidim::TranslatableResource

    translatable_fields :name

    belongs_to :assembly, foreign_key: "decidim_assembly_id", class_name: "Decidim::Assembly"
    has_many :members, foreign_key: "decidim_assemblies_extended_cadency_id", class_name: "Decidim::AssemblyMember", dependent: :nullify

    alias participatory_space assembly

    validates :name, presence: true

    def self.log_presenter_class_for(_log)
      Decidim::Assemblies::Extended::AdminLog::CadencyPresenter
    end
  end
end
