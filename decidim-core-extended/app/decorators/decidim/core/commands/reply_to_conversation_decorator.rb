# frozen_string_literal: true

Decidim::Messaging::ReplyToConversation.class_eval do

  private

  def notify(recipient)
    return unless recipient.email_on_notification # do not send email if user has email notifications turned off
    return unless conversation.unread_count(recipient) == 1
    return unless recipient.accepts_conversation?(form.context.current_user)

    yield unless @already_notified.include?(recipient)
    @already_notified.push(recipient)
  end
end
