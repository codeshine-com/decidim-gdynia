# This migration comes from decidim_processes_extended (originally 20210722111302)
class AddPromotedFieldToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_scopes, :promoted, :boolean, default: false
  end
end
