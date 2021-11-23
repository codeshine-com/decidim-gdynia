# frozen_string_literal: true

Decidim::Devise::InvitationsController.class_eval do

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:nickname, :tos_agreement, :rodo_agreements, :newsletter_notifications])
  end
end
