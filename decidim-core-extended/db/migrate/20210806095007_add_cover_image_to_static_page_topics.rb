class AddCoverImageToStaticPageTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_static_page_topics, :cover, :string
  end
end
