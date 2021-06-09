class AddAvatarToMamber < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_assembly_members, :avatar, :string
  end
end
