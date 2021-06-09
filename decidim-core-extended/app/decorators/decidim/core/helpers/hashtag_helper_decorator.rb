Decidim::MetaTagsHelper.class_eval do
  def facebook_hashtag_link(hashtag)
    link_to "##{hashtag}", "https://facebook.com/hashtag/#{hashtag}", target: "_blank"
  end
end
