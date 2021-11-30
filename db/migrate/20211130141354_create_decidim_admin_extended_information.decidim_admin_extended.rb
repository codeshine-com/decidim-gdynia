# This migration comes from decidim_admin_extended (originally 20211130140856)
class CreateDecidimAdminExtendedInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_admin_extended_information do |t|
      t.string :name
      t.text :body
      t.string :lead
      t.string :link_url
      t.boolean :published, default: false

      t.references :decidim_organization, foreign_key: true, index: { name: 'index_information_on_organization_id' }

      t.timestamps
    end
  end
end
