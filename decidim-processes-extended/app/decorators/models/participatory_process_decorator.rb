# frozen_string_literal: true

Decidim::ParticipatoryProcess.class_eval do

  def scopes
    @scopes ||= linked_participatory_space_resources(:scope, "related_scopes").all
  end
end
