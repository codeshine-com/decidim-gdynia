# frozen_string_literal: true

Decidim::PasswordsHelper.module_eval do
  # overwritten - fixed misspelled translation
  def password_field_options_for(user)
    user =
      case user
      when :user
        Decidim::User.new
      when :admin
        Decidim::User.new(admin: true)
      when String
        Decidim::User.with_reset_password_token(user)
      else
        user
      end
    min_length = ::PasswordValidator.minimum_length_for(user)
    help_text =
      if needs_admin_password?(user)
        t("devise.passwords.edit.password_help_admin", minimum_characters: min_length)
      else
        t("devise.passwords.edit.password_help", minimum_characters: min_length)
      end

    {
      autocomplete: "new-password",
      required: true,
      help_text: help_text,
      minlength: min_length,
      maxlength: ::PasswordValidator::MAX_LENGTH
    }
  end
end