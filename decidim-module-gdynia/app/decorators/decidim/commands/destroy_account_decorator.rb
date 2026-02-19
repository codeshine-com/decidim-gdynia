# frozen_string_literal: true

Decidim::DestroyAccount.class_eval do
  private

  # overwritten method
  # add custom attrs
  def destroy_user_account!
    current_user.invalidate_all_sessions!

    current_user.name = ""
    current_user.nickname = ""
    current_user.email = ""
    current_user.personal_url = ""
    current_user.about = ""
    current_user.notifications_sending_frequency = "none"
    current_user.delete_reason = @form.delete_reason
    current_user.admin = false if current_user.admin?
    current_user.deleted_at = Time.current
    current_user.skip_reconfirmation!
    current_user.avatar.purge

    # custom attr
    current_user.inhabitant_card_number = nil

    current_user.save!
  end
end
