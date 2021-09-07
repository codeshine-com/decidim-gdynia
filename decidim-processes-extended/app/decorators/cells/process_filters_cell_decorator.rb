# frozen_string_literal: true

Decidim::ParticipatoryProcesses::ProcessFiltersCell.class_eval do

  def show
    render :show_new
  end

  def should_show_tabs?
    process_count_by_filter[current_filter] > 0
  end
end
