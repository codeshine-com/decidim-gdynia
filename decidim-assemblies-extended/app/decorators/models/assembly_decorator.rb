Decidim::Assembly.class_eval do

  SOCIAL_HANDLERS = [:facebook, :instagram, :youtube, :twitter, :github].freeze

  has_many :cadencies, foreign_key: "decidim_assembly_id", class_name: "Decidim::Assemblies::Extended::Cadency", dependent: :destroy

  def main_info?
    # info shown in BOX 1
    area.present? || assembly_type.present? || created_by.present? || creation_date.present? || duration_text.present? || duration.present?
  end

  def has_any_contact?
    # info shown in BOX 2 contact field
    contact_address.present? || contact_email.present? || contact_phone.present?
  end

  def has_any_social_links?
    SOCIAL_HANDLERS.map{ |sh| self.try("#{sh}_handler").present? }.include?(true)      
  end
end
