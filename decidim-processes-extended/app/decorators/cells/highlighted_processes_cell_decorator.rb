# frozen_string_literal: true

Decidim::ParticipatoryProcesses::ContentBlocks::HighlightedProcessesCell.class_eval do
   def show
     if single_item?
        render :single_process_new
      elsif highlighted_items.any?
        render :show_new
      end
   end
end
