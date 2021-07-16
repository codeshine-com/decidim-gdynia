class AddCadencyToAssemblyMember < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_assembly_members, :decidim_assemblies_extended_cadency, index: { name: "decidim_assembly_members_on_cadency_id" }
  end
end
