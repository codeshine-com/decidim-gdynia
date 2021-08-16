# frozen_string_literal: true

Decidim::User.class_eval do
  GENDERS = ['male', 'female', 'no_answer'].freeze
  AGE = %w(below_18 from_18_to_24 from_25_to_34 from_35_to_54 from_55_to_74 over_74).freeze

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

  def answer_match?(answer, metrics)
    case metrics
    when 'age'
      return false unless birth_year

      user_age = Date.current.year - birth_year
      if user_age < 18 && answer.body['pl'] == I18n.t("ages.#{AGE[0]}", scope: "activemodel.attributes.user")
        true
      elsif user_age >= 18 && user_age < 25 && answer.body['pl'] == I18n.t("ages.#{AGE[1]}", scope: "activemodel.attributes.user")
        true
      elsif user_age >= 25 && user_age < 35 && answer.body['pl'] == I18n.t("ages.#{AGE[2]}", scope: "activemodel.attributes.user")
        true
      elsif user_age >= 35 && user_age < 55 && answer.body['pl'] == I18n.t("ages.#{AGE[3]}", scope: "activemodel.attributes.user")
        true
      elsif user_age >= 55 && user_age < 75 && answer.body['pl'] == I18n.t("ages.#{AGE[4]}", scope: "activemodel.attributes.user")
        true
      elsif user_age >= 75 && answer.body['pl'] == I18n.t("ages.#{AGE[5]}", scope: "activemodel.attributes.user")
        true
      else
        false
      end
    when 'gender'
      return false unless gender

      answer.body['pl'] == I18n.t("genders.#{gender}", scope: "activemodel.attributes.user")
    when 'district'
      return false unless district
       
      answer.body['pl'] == district
    else
      false
    end

  end

end
