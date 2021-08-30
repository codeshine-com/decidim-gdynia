Decidim::Surveys::Survey.class_eval do

  def private?
    component.settings.private_survey
  end

  def transparent?
    component.settings.transparent
  end

  def current_user_can_visit_survey?(user)
    return true if user&.admin
    return true if user && (component.participatory_space.user_roles(role_name = 'admin').pluck(:decidim_user_id).include? user.id)
    return visible_for_unregistered unless user

    private? && !transparent? ? (user && component.participatory_space.participatory_space_private_users.exists?(decidim_user_id: user.id)) : true
  end

end
