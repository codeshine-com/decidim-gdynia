$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "decidim/core/extended/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "decidim-core-extended"
  spec.version     = Decidim::Core::Extended::VERSION
  spec.authors     = ["Paulina Kamińska"]
  spec.email       = ["paulina.kaminska@codeshine.com"]
  spec.summary     = "Summary of Decidim::Core::Extended."
  spec.description = "Description of Decidim::Core::Extended."
  spec.license     = "MIT"


  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "decidim-core", Decidim::Core::Extended::DECIDIM_VERSION
end
