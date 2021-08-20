# frozen_string_literal: true

Decidim::ContentBlocks::HowToParticipateCell.class_eval do
  include Rails.application.routes.mounted_helpers
  
  def show
    render :show_new
  end

end
