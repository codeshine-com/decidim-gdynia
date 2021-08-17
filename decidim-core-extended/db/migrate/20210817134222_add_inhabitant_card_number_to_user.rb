class AddInhabitantCardNumberToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :inhabitant_card_number, :integer
  end
end
