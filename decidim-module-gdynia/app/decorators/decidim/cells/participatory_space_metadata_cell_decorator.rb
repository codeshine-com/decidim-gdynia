# frozen_string_literal: true

Decidim::ContentBlocks::ParticipatorySpaceMetadataCell.class_eval do
  # overwritten method
  # rebuild method - drop decidim_escape_translated
  # translate to PL value for const attr created_by
  def metadata_valued_items
    metadata_items.filter_map do |item|
      raw_value = presented_space.send(item)
      value = if item == "created_by" && raw_value.present?
                I18n.t("decidim.assemblies.created_by.#{raw_value}", default: raw_value)
              else
                translated_attribute(raw_value)
              end
      next if value.blank?

      {
        title: t(item, scope: translations_scope),
        value:
      }
    end
  end
end
