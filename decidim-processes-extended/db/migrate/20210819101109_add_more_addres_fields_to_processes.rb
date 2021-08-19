class AddMoreAddresFieldsToProcesses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_processes, :contact_email, :string
    add_column :decidim_participatory_processes, :contact_phone, :string
  end
end
