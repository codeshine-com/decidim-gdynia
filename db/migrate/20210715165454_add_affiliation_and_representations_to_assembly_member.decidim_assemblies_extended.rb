# This migration comes from decidim_assemblies_extended (originally 20210408182743)
class AddAffiliationAndRepresentationsToAssemblyMember < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_assembly_members, :affiliation, :string
    add_column :decidim_assembly_members, :representation, :string
  end
end
