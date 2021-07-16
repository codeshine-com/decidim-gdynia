Decidim::Proposals::ProposalsController.class_eval do
  before_action :check_privacy_of_component, only: :index

  def show
    redirect_to({ action: :index }, alert: I18n.t("proposal.not_allowed", scope: "decidim.proposals")) if @proposal.blank? || !can_show_proposal?
  end

  private

  def check_privacy_of_component
    redirect_to(participatory_space_link, alert: I18n.t("proposal.not_allowed", scope: "decidim.proposals")) if current_component.has_to_be_hidden?(current_user)
  end

  def can_show_proposal?
    return @proposal.current_user_can_visit_proposals?(current_user) if @proposal.private? && !@proposal.transparent?
    return true if @proposal&.amendable? || current_user&.admin?

    Decidim::Proposals::Proposal.only_visible_emendations_for(current_user, current_component).published.include?(@proposal)
  end

  def participatory_space_link
    current_component.participatory_space.class.name == 'Decidim::ParticipatoryProcess' ?
                  decidim_participatory_processes.participatory_process_path(current_component.participatory_space)
                  : decidim_assemblies.assembly_path(current_component.participatory_space)

  end
end
