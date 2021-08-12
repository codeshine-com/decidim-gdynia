# frozen_string_literal: true

Decidim::ParticipatoryProcesses::ParticipatoryProcessHelper.class_eval do
  def step_dates(participatory_process_step)
    if participatory_process_step.start_date == participatory_process_step.end_date && participatory_process_step.start_date.present?
      localize(participatory_process_step.start_date.to_date, format: :default)
    else
      dates = [participatory_process_step.start_date, participatory_process_step.end_date]
      dates.map { |date| date ? localize(date.to_date, format: :default) : "?" }.join(" - ")
    end
  end
end
