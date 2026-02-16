# frozen_string_literal: true

Decidim::ContentBlocks::ParticipatorySpaceMetadataCell.class_eval do

  def metadata_valued_items
    metadata_items.filter_map do |item|
      next if (decidim_escape_translated(presented_space.send(item))).blank?

      value = translated_attribute(presented_space.send(item))
      {
        title: t(item, scope: translations_scope),
        value:
      }
    end
  end

end

