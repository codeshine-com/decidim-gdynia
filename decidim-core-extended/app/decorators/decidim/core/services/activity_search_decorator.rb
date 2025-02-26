# TODO: do aktualizacji - zmiana w 0.27
# Decidim::ActivitySearch => Decidim::PublicActivities

# Decidim::ActivitySearch.class_eval do
#
#   private
#
#   def filter_follows(query)
#     follows = options[:follows]
#     interesting_scopes = options[:scopes]
#     interesting_areas = options[:areas]
#     conditions = []
#
#     if follows.present?
#       conditions += follows.group_by(&:decidim_followable_type).map do |type, grouped_follows|
#         Decidim::ActionLog.arel_table[:resource_type].eq(type).and(
#           Decidim::ActionLog.arel_table[:resource_id].in(grouped_follows.map(&:decidim_followable_id))
#         )
#       end
#
#       conditions += followed_users_conditions(follows)
#       conditions += followed_spaces_conditions(follows)
#     end
#
#     conditions += interesting_scopes_conditions(interesting_scopes)
#     conditions += interesting_areas_conditions(interesting_areas)
#
#     return query if conditions.empty?
#
#     chained_conditions = conditions.inject do |previous_condition, condition|
#       next condition unless previous_condition
#
#       previous_condition.or(condition)
#     end
#
#     query.where(chained_conditions)
#   end
#
#   def interesting_areas_conditions(interesting_areas)
#     return [] if interesting_areas.blank?
#
#     [Decidim::ActionLog.arel_table[:decidim_area_id].in(interesting_areas.map(&:id))]
#   end
# end
