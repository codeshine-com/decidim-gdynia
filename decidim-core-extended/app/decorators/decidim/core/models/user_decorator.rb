# frozen_string_literal: true

Decidim::User.class_eval do

  attr_accessor :rodo_agreements

  scope :interested_in_areas, lambda { |area_ids|
      actual_ids = area_ids.select(&:presence)
      if actual_ids.count.positive?
        ids = actual_ids.map(&:to_i).join(",")
        where("extended_data->'interested_areas' @> ANY('{#{ids}}')")
      else
        # Do not apply the area filter when there are area ids available. Note
        # that the active record area must always return an active record
        # collection.
        self
      end
    }

  def interested_areas_ids
    extended_data["interested_areas"] || []
  end

  def interested_areas
    @interested_areas ||= organization.areas.where(id: interested_areas_ids)
  end

end
