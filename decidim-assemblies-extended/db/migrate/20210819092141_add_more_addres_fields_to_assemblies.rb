class AddMoreAddresFieldsToAssemblies < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_assemblies, :contact_email, :string
    add_column :decidim_assemblies, :contact_phone, :string
  end
end
