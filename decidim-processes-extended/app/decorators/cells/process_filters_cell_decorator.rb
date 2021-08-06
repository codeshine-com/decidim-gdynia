# frozen_string_literal: true

Decidim::ParticipatoryProcesses::ProcessFiltersCell.class_eval do
  def process_count_by_filter
    return @process_count_by_filter if @process_count_by_filter

    @process_count_by_filter = %w(active upcoming past).inject({}) do |collection_by_filter, filter_name|
      filtered_processes = filtered_processes(filter_name).results
      processes = filtered_processes.groupless
      groups = Decidim::ParticipatoryProcessGroup.where(id: filtered_processes.grouped.group_ids).uniq
      collection_by_filter.merge(filter_name => processes.count + groups.count)
    end
    @process_count_by_filter["all"] = @process_count_by_filter.values.sum
    @process_count_by_filter
  end
end
