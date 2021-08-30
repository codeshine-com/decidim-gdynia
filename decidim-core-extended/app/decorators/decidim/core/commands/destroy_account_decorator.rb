# frozen_string_literal: true

Decidim::DestroyAccount.class_eval do

  private

  def destroy_user_account!
    @user.invalidate_all_sessions!

    @user.name = ""
    @user.nickname = ""
    @user.email = ""
    @user.inhabitant_card_number = nil # custom
    @user.delete_reason = @form.delete_reason
    @user.admin = false if @user.admin?
    @user.deleted_at = Time.current
    @user.skip_reconfirmation!
    @user.remove_avatar!
    @user.save!
  end
end
