# frozen_string_literal: true

# TODO: do aktualizacji - usuniete w 0.27
# chyba zmiany dotycza: decidim-processes-extended/app/views/decidim/shared/participatory_space_filters/_filters.html.erb

# Decidim::ParticipatoryProcesses::ParticipatoryProcessSearch.class_eval do
#
#   def search_scope_id
#     clean_scope_ids = if scope_id.is_a?(Hash)
#                         scope_id.values
#                       else
#                         [scope_id].flatten
#                       end
#
#     if clean_scope_ids.any?
#       query.joins(:participatory_space_resource_links_from).where('decidim_participatory_space_links.to_type': 'Decidim::Scope').where('decidim_participatory_space_links.to_id': clean_scope_ids)
#     else
#       query
#     end
#   end
# end
