# frozen_string_literal: true

Decidim::Assemblies::AssemblyMemberCell.class_eval do
  include Rails.application.routes.mounted_helpers

  property :affiliation
  property :representation
  property :ceased_date

  def show
    render :new_show
  end

end
