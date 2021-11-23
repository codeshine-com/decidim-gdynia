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

  def can_be_joined_by?(user)
    !closed? && registrations_enabled? && !private_meeting? && can_participate?(user)
    # !closed? && registrations_enabled? && on_this_platform? && can_participate?(user)
  end

  private

  def can_participate_in_meeting?(user)
    return true if private_meeting? && user_permitted_for_private_meeting_actions?(user)
    return false unless user

    registrations.exists?(decidim_user_id: user.id)
  end

  def user_permitted_for_private_meeting_actions?(user)
    user.admin? || space_admin?(user) || private_user?(user)
  end

  def private_user?(user)
    meeting.participatory_space.participatory_space_private_users.map(&:decidim_user_id).include?(user.id)
  end

  def space_admin?(user)
    meeting.participatory_space.user_roles.map(&:decidim_user_id).include?(user.id)
  end
end
