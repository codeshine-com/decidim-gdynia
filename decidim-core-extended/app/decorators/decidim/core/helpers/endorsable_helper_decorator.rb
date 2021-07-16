Decidim::EndorsableHelper.class_eval do

  def current_user_can_endorse?
    current_user && endorsements_enabled? && !endorsements_blocked? && current_component.current_user_can_take_actions?(current_user)
  end

end
