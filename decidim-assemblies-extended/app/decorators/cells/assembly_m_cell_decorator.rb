# frozen_string_literal: true

Decidim::Assemblies::AssemblyMCell.class_eval do
  def show
    render :show_new
  end

  private

  def creation_date_status
    if model.creation_date
      l(model.creation_date, format: :decidim_short)
    elsif model.cadencies.any?
      l(model.cadencies.order('weight DESC').first.created_at, format: :decidim_short)
    end
  end
end
