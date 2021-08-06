# This migration comes from decidim_core_extended (originally 20210802115733)
class AddIconToAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_areas, :icon, :string
  end
end
