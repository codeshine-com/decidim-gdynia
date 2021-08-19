class ChangeInhabitantCardNumberToString < ActiveRecord::Migration[5.2]
  def change
    change_column :decidim_users, :inhabitant_card_number, :string
  end
end
