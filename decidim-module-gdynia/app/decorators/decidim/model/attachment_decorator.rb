# frozen_string_literal: true

Decidim::Attachment.class_eval do
  #fix for bug on update to v030
  def can_participate?(_step)
    false
  end
end
