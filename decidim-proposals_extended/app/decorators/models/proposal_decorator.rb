Decidim::Proposals::Proposal.class_eval do

  def user_allowed_to_comment?(user)
    can_participate_in_space?(user) && current_user_can_take_actions?(user)
  end

  def private?
    component.settings.private_proposal
  end

  def transparent?
    component.settings.transparent
  end

  def current_user_can_visit_proposals?(user)
    return true if user&.admin
    return true if user && (component.participatory_space.user_roles(role_name = 'admin').pluck(:decidim_user_id).include? user.id)

    if private? && !transparent?
      user ? (user && component.participatory_space.participatory_space_private_users.exists?(decidim_user_id: user.id)) : false
    else
      true
    end
  end

  def current_user_can_take_actions?(user)
    return true if user&.admin
    return true if user && (component.participatory_space.user_roles(role_name = 'admin').pluck(:decidim_user_id).include? user.id)

    if private?
      user && component.participatory_space.participatory_space_private_users.exists?(decidim_user_id: user.id)
    else
      true
    end
  end

end
