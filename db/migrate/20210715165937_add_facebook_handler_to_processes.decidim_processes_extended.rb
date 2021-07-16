# This migration comes from decidim_processes_extended (originally 20210513153913)
class AddFacebookHandlerToProcesses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_processes, :facebook_handler, :string
  end
end
