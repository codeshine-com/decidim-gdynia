# frozen_string_literal: true

Decidim::Assemblies::ContentBlocks::MetadataCell.class_eval do
  private

  def metadata_items
    %w(contact team_service)
  end
end
