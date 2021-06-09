Decidim::Meetings::Meeting.class_eval do

  def mounted_engine
    "decidim_#{component.participatory_space.underscored_name}_meetings"
  end

  def mounted_params
    {
      host: component.organization.host,
      component_id: component.id,
      "#{component.participatory_space.underscored_name}_slug".to_sym => component.participatory_space.slug
    }
  end

end
