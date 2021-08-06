# frozen_string_literal: true

Decidim::ParticipatoryProcesses::ParticipatoryProcessSearch.class_eval do

  def search_scope_id
    clean_scope_ids = if scope_id.is_a?(Hash)
                        scope_id.values
                      else
                        [scope_id].flatten
                      end
    # conditions = []
    # conditions << "decidim_scope_id IS NULL" if clean_scope_ids.delete("global")
    # conditions.concat(["? = ANY(decidim_scopes.part_of)"] * clean_scope_ids.count) if clean_scope_ids.any?
    if clean_scope_ids.any?
      query.joins(:participatory_space_resource_links_from).where('decidim_participatory_space_links.to_type': 'Decidim::Scope').where('decidim_participatory_space_links.to_id': clean_scope_ids)
    else
      query
    end
  end
end
