Decidim::UserTimelineController.class_eval do

  private

  def activities
      @activities ||= paginate(
        Decidim::PublicActivities.new(
          current_organization,
          scopes: current_user.interested_scopes,
          areas: current_user.interested_areas,
          follows: follows,
          resource_name: filter.resource_type
        ).query.with_resource_type("all")
      )
    end
end
