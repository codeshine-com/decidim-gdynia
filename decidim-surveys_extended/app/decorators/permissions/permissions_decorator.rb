Decidim::Surveys::Admin::Permissions.class_eval do
  def permissions
    return permission_action unless user

    return permission_action unless permission_action.scope == :admin

    case permission_action.subject
    when :questionnaire
      case permission_action.action
      when :export_answers, :update
        permission_action.allow!
      when :preview
        permission_action.allow!
      end
    when :questionnaire_answers
      case permission_action.action
      when :index, :show, :export_response
        permission_action.allow!
      end
    end

    permission_action
  end
end