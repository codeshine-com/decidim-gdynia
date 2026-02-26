# frozen_string_literal: true

Decidim::Attachment.class_eval do
  def can_participate?(_step)
    false
  end
end
