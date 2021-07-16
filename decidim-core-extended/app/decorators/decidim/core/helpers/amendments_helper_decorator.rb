Decidim::AmendmentsHelper.class_eval do

  def amend_button_for(amendable)
    return unless amendments_enabled? && amendable.amendable?
    return unless current_component.current_settings.amendment_creation_enabled
    return unless can_participate_in_private_space?
    return unless current_component.current_user_can_take_actions?(current_user)

    cell("decidim/amendable/amend_button_card", amendable)
  end
end
