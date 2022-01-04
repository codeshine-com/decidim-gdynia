# frozen_string_literal: true

Decidim::ParticipatoryProcesses::ParticipatoryProcessHelper.class_eval do
  def step_dates(participatory_process_step)
    if participatory_process_step.start_date == participatory_process_step.end_date && participatory_process_step.start_date.present?
      localize(participatory_process_step.start_date.to_date, format: :decidim_short)
    else
      dates = [participatory_process_step.start_date, participatory_process_step.end_date]
      dates.map { |date| date ? "<strong>#{localize(date.to_date, format: :decidim_short)}</strong>" : "<strong>?</strong>" }.join(" - ").html_safe
    end
  end
end
