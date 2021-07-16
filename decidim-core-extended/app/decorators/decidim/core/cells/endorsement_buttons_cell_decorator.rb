Decidim::EndorsementButtonsCell.class_eval do

  def endorsements_blocked_or_user_can_not_participate?
    current_settings.endorsements_blocked? || !current_component.participatory_space.can_participate?(current_user) || !current_user_can_endorse?
  end

  def current_user_and_allowed?
    current_user && allowed_to?(:create, :endorsement, resource: resource) && current_user_can_endorse?
  end

end
