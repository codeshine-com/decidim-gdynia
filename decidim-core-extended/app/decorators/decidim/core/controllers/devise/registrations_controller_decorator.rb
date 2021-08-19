# frozen_string_literal: true

Decidim::Devise::RegistrationsController.class_eval do

  def create
    @form = form(Decidim::RegistrationForm).from_params(params[:user].merge(current_locale: current_locale))

    Decidim::CreateRegistration.call(@form) do
      on(:ok) do |user|
        if user.authorized_with_inhabitant_card? || true
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
        flash.now[:alert] = @form.errors[:base].join(", ") if @form.errors[:base].any?
        render :new
      end
    end
  end
end
