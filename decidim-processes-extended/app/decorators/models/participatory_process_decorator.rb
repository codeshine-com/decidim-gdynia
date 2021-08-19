# frozen_string_literal: true

Decidim::ParticipatoryProcess.class_eval do

  def scopes
    @scopes ||= linked_participatory_space_resources(:scope, "related_scopes").all
  end

  def has_any_contact?
    # info shown in BOX 2 contact field
    contact_address.present? || contact_email.present? || contact_phone.present?
  end 
end
