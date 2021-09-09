# frozen_string_literal: true

Decidim::ContentBlocks::SubHeroCell.class_eval do

  def show
    return if translated_attribute(current_organization.description).blank?

    render :show_new
  end
end
