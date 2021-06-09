Decidim::UpdateUserInterests.class_eval do

  private

    def update_interests
      @user.extended_data ||= {}
      @user.extended_data["interested_scopes"] = selected_scopes_ids
      @user.extended_data["interested_areas"] = selected_areas_ids
    end

    def selected_areas_ids
      @form.areas.select(&:checked).map(&:id)
    end
end
