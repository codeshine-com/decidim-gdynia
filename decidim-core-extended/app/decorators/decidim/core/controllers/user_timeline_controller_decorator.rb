Decidim::UserTimelineController.class_eval do

  private

  def activities
      @activities ||= paginate(
        Decidim::ActivitySearch.new(
          organization: current_organization,
          resource_type: "all",
          scopes: current_user.interested_scopes,
          areas: current_user.interested_areas,
          follows: follows,
          resource_name: filter.resource_type
        ).run
      )
    end
end
