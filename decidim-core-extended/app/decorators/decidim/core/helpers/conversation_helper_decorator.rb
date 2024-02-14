# frozen_string_literal: true

Decidim::Messaging::ConversationHelper.class_eval do

  #
  # Generates a visualization of users for listing conversations threads
  #
  def username_list(users, shorten: false)
    content_tags = []
    first_users = shorten ? users.first(3) : users
    first_users.each do |u|
      content_tags.push(u.deleted? ? content_tag(:strong, t("decidim.profile.deleted")) : content_tag(:strong, u.name))
    end

    return content_tags.join(", ") unless shorten
    return content_tags.join(", ") unless users.count > 3

    content_tags.push(content_tag(:strong, " + #{users.count - 3}"))
    content_tags.join(", ")
  end
end
