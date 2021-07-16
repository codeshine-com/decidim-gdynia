# This migration comes from decidim_assemblies_extended (originally 20210706110013)
class CreateDecidimAssembliesExtendedCadencies < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_assemblies_extended_cadencies do |t|
      t.jsonb :name
      t.integer :weight, null: false
      t.references :decidim_assembly, null: false, index: { name: "decidim_assembly_assemblies_extended_cadency" }
      t.timestamps
    end
  end
end
