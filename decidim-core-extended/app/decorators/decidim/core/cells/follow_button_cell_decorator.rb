# frozen_string_literal: true

Decidim::FollowButtonCell.class_eval do
  def show
      return if model == current_user

      render :show_new
    end
end
