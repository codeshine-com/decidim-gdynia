Decidim::Assembly.class_eval do

  SOCIAL_HANDLERS = [:facebook, :instagram, :youtube, :twitter, :github].freeze

  has_many :cadencies, foreign_key: "decidim_assembly_id", class_name: "Decidim::Assemblies::Extended::Cadency", dependent: :destroy

end
