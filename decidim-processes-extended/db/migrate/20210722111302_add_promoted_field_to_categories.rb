class AddPromotedFieldToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_scopes, :promoted, :boolean, default: false
  end
end
