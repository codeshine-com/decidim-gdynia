# frozen_string_literal: true

Decidim::Admin::BlockUser.class_eval do

  private

  def block!
    Decidim.traceability.perform_action!(
      "block",
      form.user,
      form.current_user,
      extra: {
        reportable_type: form.user.class.name,
        current_justification: form.justification
      }
    ) do
      form.user.blocked = true
      form.user.blocked_at = Time.current
      form.user.blocking = @current_blocking
      form.user.extended_data["user_name"] = form.user.name
      form.user.name = t('decidim.admin.block_user.new.new_name')
      form.user.save!
    end
  end
end
