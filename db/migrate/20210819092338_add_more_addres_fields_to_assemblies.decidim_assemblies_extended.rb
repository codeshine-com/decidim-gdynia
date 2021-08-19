# This migration comes from decidim_assemblies_extended (originally 20210819092141)
class AddMoreAddresFieldsToAssemblies < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_assemblies, :contact_email, :string
    add_column :decidim_assemblies, :contact_phone, :string
  end
end
