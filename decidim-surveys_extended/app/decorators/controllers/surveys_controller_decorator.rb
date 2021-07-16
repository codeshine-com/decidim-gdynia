Decidim::Surveys::SurveysController.class_eval do

  def show
    if questionnaire_for.current_user_can_visit_survey?(current_user)
      @form = form(Decidim::Forms::QuestionnaireForm).from_model(questionnaire)
      render template: "decidim/forms/questionnaires/show"
    else
      flash[:alert] = I18n.t("survey.not_allowed", scope: "decidim.surveys")
      redirect_to(participatory_space_link)
    end
  end

  def participatory_space_link
    current_component.participatory_space.class.name == 'Decidim::ParticipatoryProcess' ?
                  decidim_participatory_processes.participatory_process_path(current_component.participatory_space)
                  : decidim_assemblies.assembly_path(current_component.participatory_space)

  end
end
