# frozen_string_literal: true

Decidim::CreateRegistration.class_eval do

  def call
    if form.invalid?
      user = Decidim::User.has_pending_invitations?(form.current_organization.id, form.email)
      user.invite!(user.invited_by) if user
      return broadcast(:invalid)
    end

    if form.card_number.present? && !verify_card
      form.errors.add(:card_number, t('activemodel.attributes.user.inhabitant_card_number_error'))
      return broadcast(:invalid)
    end

    create_user

    broadcast(:ok, @user)
  rescue ActiveRecord::RecordInvalid
    broadcast(:invalid)
  end

  private

  def verify_card
    Decidim::Core::Extended::InhabitantCardService.new(form).call
  end

  def create_user
    @user = Decidim::User.create!(
      email: form.email,
      name: form.name,
      nickname: form.nickname,
      password: form.password,
      password_confirmation: form.password_confirmation,
      organization: form.current_organization,
      tos_agreement: form.tos_agreement,
      newsletter_notifications_at: form.newsletter_at,
      email_on_notification: true,
      accepted_tos_version: form.current_organization.tos_version,
      locale: form.current_locale,
      # custom
      inhabitant_card_number: form.card_number.presence || nil
    )
  end
end
