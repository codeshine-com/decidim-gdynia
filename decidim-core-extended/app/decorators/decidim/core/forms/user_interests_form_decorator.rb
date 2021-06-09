Decidim::UserInterestsForm.class_eval do
  attribute :areas, Array[Decidim::UserInterestAreaForm]

    def map_model(user)
      self.scopes = user.organization.scopes.top_level.map do |scope|
        Decidim::UserInterestScopeForm.from_model(scope: scope, user: user)
      end
      self.areas = user.organization.areas.map do |area|
        Decidim::UserInterestAreaForm.from_model(area: area, user: user)
      end
    end
end
