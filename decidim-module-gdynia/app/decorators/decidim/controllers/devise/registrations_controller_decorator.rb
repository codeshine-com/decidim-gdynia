# frozen_string_literal: true

Decidim::Devise::RegistrationsController.class_eval do
  # overwritten method action
  # swap user.active_for_authentication? with user.authorized_with_inhabitant_card?
  # add user.confirm
  def create
    @form = form(Decidim::RegistrationForm).from_params(params[:user].merge(current_locale:))

    Decidim::CreateRegistration.call(@form) do
      on(:ok) do |user|
        if user.authorized_with_inhabitant_card?
          user.confirm
          set_flash_message! :notice, :signed_up
          sign_up(:user, user)
          respond_with user, location: decidim.account_path
        else
          set_flash_message! :notice, :"signed_up_but_#{user.inactive_message}"
          expire_data_after_sign_in!
          respond_with user, location: after_inactive_sign_up_path_for(user)
        end
      end

      on(:invalid) do
        flash.now[:alert] = t("error", scope: "decidim.devise.registrations.create")
        render :new
      end
    end
  end
end
