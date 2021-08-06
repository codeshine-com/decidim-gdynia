# This migration comes from decidim_core_extended (originally 20210806095007)
class AddCoverImageToStaticPageTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_static_page_topics, :cover, :string
  end
end
