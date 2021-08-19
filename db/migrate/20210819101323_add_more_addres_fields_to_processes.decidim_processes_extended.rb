# This migration comes from decidim_processes_extended (originally 20210819101109)
class AddMoreAddresFieldsToProcesses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_processes, :contact_email, :string
    add_column :decidim_participatory_processes, :contact_phone, :string
  end
end
