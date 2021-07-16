Decidim::Meetings::RegistrationsController.class_eval do

  def answer
    enforce_permission_to :register, :meeting, meeting: meeting

    @form = form(Decidim::Forms::QuestionnaireForm).from_params(params, session_token: session_token)

    Decidim::Meetings::JoinMeeting.call(meeting, current_user, @form) do
      on(:ok) do
        flash[:notice] = I18n.t("registrations.create.success", scope: "decidim.meetings")
        redirect_to after_answer_path
      end

      on(:invalid) do
        flash.now[:alert] = I18n.t("registrations.create.invalid", scope: "decidim.meetings")
        render template: "decidim/forms/questionnaires/show"
      end

      on(:invalid_form) do
        flash.now[:alert] = I18n.t("answer.invalid", scope: i18n_flashes_scope)
        render template: "decidim/forms/questionnaires/show"
      end
    end
  end
end
