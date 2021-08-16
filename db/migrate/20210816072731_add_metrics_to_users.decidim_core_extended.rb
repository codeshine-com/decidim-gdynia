# This migration comes from decidim_core_extended (originally 20210815194645)
class AddMetricsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :gender, :string
    add_column :decidim_users, :birth_year, :integer
    add_column :decidim_users, :district, :string
  end
end
