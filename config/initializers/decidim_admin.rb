# Overwritten
# remove decidim-templates from dependencies list - bug in 0.26.9 withouth decidim-templates gem
Decidim::DependencyResolver.class_eval do
  def needed?(spec)
    return false if 'decidim-templates'

    spec = lookup(spec)
    return false unless spec

    if bundler?
      available?(spec)
    else
      loaded?(spec)
    end
  end
end