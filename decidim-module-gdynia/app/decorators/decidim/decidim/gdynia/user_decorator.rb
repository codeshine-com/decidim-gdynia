# frozen_string_literal: true

Decidim::User.class_eval do
  def authorized_with_inhabitant_card?
    inhabitant_card_number.present?
  end
end
