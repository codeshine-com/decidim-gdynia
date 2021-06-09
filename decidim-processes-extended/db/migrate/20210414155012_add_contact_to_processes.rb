class AddContactToProcesses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_processes, :contact_address, :string
  end
end
