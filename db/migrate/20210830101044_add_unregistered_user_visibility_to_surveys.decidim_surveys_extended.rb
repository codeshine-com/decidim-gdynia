# This migration comes from decidim_surveys_extended (originally 20210830094833)
class AddUnregisteredUserVisibilityToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_surveys_surveys, :visible_for_unregistered, :boolean, default: false
  end
end
