Decidim::Proposals::ProposalVotesHelper.class_eval do

  def current_user_can_vote?
    current_user && votes_enabled? && vote_limit_enabled? && !votes_blocked? && current_component.current_user_can_take_actions?(current_user)
  end

end
