# frozen_string_literal: true

Devise::Models::Confirmable.module_eval do

  def send_confirmation_instructions
    return if resource_is_inhabitant?

    unless @raw_confirmation_token
      generate_confirmation_token!
    end

    opts = pending_reconfirmation? ? { to: unconfirmed_email } : { }
    send_devise_notification(:confirmation_instructions, @raw_confirmation_token, opts)
  end

  def resource_is_inhabitant?
    self.class.name == "Decidim::User" && self.authorized_with_inhabitant_card?
  end
end
