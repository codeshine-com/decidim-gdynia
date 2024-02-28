# frozen_string_literal: true

Decidim::PublicActivities.class_eval do
  def initialize(organization, options = {})
    @organization = organization
    @resource_name = options[:resource_name]
    @user = options[:user]
    @current_user = options[:current_user]
    @follows = options[:follows]
    @scopes = options[:scopes]
    @areas = options[:areas]
  end

  private

  attr_reader :areas

  def filter_follows(query)
    conditions = []

    if follows.present?
      conditions += follows.group_by(&:decidim_followable_type).map do |type, grouped_follows|
        Decidim::ActionLog.arel_table[:resource_type].eq(type).and(
          Decidim::ActionLog.arel_table[:resource_id].in(grouped_follows.map(&:decidim_followable_id))
        )
      end

      conditions += followed_users_conditions(follows)
      conditions += followed_spaces_conditions(follows)
    end

    conditions += interesting_scopes_conditions(scopes)
    conditions += interesting_areas_conditions(areas)

    return query if conditions.empty?

    chained_conditions = conditions.inject do |previous_condition, condition|
      previous_condition.present? ? previous_condition.or(condition) : condition
    end

    query.where(chained_conditions)
  end

  def interesting_areas_conditions(interesting_areas)
    return [] if interesting_areas.blank?

    [Decidim::ActionLog.arel_table[:decidim_area_id].in(interesting_areas.map(&:id))]
  end
end