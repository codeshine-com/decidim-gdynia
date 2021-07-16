Decidim::Component.class_eval do

  def has_to_be_hidden?(user)
    return false if user&.admin?
    return private? && !transparent? && (!user || !participatory_space.participatory_space_private_users.exists?(decidim_user_id: user&.id))

    false
  end

  def private?
    return settings.private_survey if manifest_name == 'surveys'
    return settings.private_proposal if manifest_name == 'proposals'

    false
  end

  def transparent?
    return settings.transparent if manifest_name == 'surveys' || manifest_name == 'proposals'

    true
  end

  def current_user_can_take_actions?(user)
    return true if user&.admin?

    if private?
      return user && participatory_space.participatory_space_private_users.exists?(decidim_user_id: user.id)
    else
      return false
    end
  end
end
