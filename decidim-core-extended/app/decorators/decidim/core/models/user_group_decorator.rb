# frozen_string_literal: true

require_dependency "devise/models/decidim_validatable"
require "valid_email2"

Decidim::UserGroup.class_eval do

  # Check if the user account has been deleted or not
  def deleted?
    deleted_at.present?
  end
end
