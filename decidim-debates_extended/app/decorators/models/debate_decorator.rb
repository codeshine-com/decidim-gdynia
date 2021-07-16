Decidim::Debates::Debate.class_eval do

  def allowed_to_destroy?
    comments.none?
  end
end
