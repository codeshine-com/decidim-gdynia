class AddNewFieldsToAssemblies < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_assemblies, :duration_text, :string, after: :duration
    add_column :decidim_assemblies, :next_meeting_date, :date
    add_column :decidim_assemblies, :contact_address, :string
    add_column :decidim_assemblies, :team_service, :string
  end
end
