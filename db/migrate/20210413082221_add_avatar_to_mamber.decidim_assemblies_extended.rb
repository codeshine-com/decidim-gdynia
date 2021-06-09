# This migration comes from decidim_assemblies_extended (originally 20210413081501)
class AddAvatarToMamber < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_assembly_members, :avatar, :string
  end
end
