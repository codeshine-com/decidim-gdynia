# frozen_string_literal: true

Decidim::Assemblies::ContentBlocks::HighlightedAssembliesCell.class_eval do
  def show
     render :show_new if highlighted_assemblies.any?
   end
end
