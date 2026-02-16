# frozen_string_literal: true

Decidim::ParticipatoryProcesses::ContentBlocks::MetadataCell.class_eval do
  private
  def metadata_items
    %w(participatory_scope target participatory_structure area_name meta_scope local_area developer_group contact)
  end
end

