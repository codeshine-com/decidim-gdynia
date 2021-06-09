class AddFacebookHandlerToProcesses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_processes, :facebook_handler, :string
  end
end
