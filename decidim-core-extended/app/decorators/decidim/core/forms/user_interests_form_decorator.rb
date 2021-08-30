# frozen_string_literal: true

Decidim::UserInterestsForm.class_eval do
  attribute :areas, Array[Decidim::UserInterestAreaForm]

  def map_model(user)
    self.scopes = user.organization.scopes.top_level.promoted_first.map do |scope|
      Decidim::UserInterestScopeForm.from_model(scope: scope, user: user)
    end
    self.areas = Decidim::Area.where(decidim_organization_id: user.organization.id).order(area_type_id: :desc).map do |area|
      Decidim::UserInterestAreaForm.from_model(area: area, user: user, area_type: area.area_type)
    end
  end
end
