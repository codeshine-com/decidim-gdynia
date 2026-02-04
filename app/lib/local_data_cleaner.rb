# frozen_string_literal: true

class LocalDataCleaner

  def process(email:)
    clean_organization
    reset_local_passwords_for(email) if email
    anonymize_users_data(email)
    reset_users_notifications(email)
    # clean_up_versions
  end

  # Czysci dane serwera SMTP w organizacji
  def clean_organization
    default_organization = Decidim::Organization.first
    default_organization.update_columns(
      host: 'localhost',
      smtp_settings: {
        'from' => '', 'port' => '', 'address' => '', 'user_name' => '', 'from_email' => '', 'from_label' => '', 'encrypted_password' => nil
      }
    )
  end

  # Ustawia wszystkim userom haslo takie samo jak znalezionego uzytkownika
  # @param email - to email lokalnego uzytkownika - admina,
  def reset_local_passwords_for(email)
    user = Decidim::User.find_by email: email
    raise 'Brak uzytkownika' unless user

    Decidim::User.update_all(encrypted_password: user.encrypted_password)
  end

  def clean_up_versions
    Decidim::ActionLog.delete_all
    ActiveRecord::Base.connection.execute("TRUNCATE Versions")
    user_manager
  end

  def anonymize_users_data(without_email = nil)
    Decidim::User.transaction do
      users = Decidim::User
      users = users.where.not(email: without_email) if without_email
      users.find_each do |user|
        user.update_columns(
          email: "example-#{user.id}-@example.com",
          # nickname: ''
          name: Faker::Name.name
        )
      end
    end
    true
  end

  def reset_users_notifications(without_email)
    users = Decidim::User
    users = users.where.not(email: without_email) if without_email
    users.update_all(
      notification_settings: {
        close_meeting_reminder: false
      },
      email_on_moderations: false,
      email_on_assigned_proposals: false,
      newsletter_notifications_at: nil,
      notifications_sending_frequency: 'none'
      # notifications_from_followed: false, # ?
      # notifications_from_own_activity: false # ?
    )
  end

end
