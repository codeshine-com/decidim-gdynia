$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "decidim/surveys_extended/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "decidim-surveys_extended"
  spec.version     = Decidim::SurveysExtended::VERSION
  spec.authors     = ["Paulina Kamińska"]
  spec.email       = ["paulina.kaminska@codeshine.com"]
  spec.summary     = "Summary of Decidim::SurveysExtended."
  spec.description = "Description of Decidim::SurveysExtended."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "decidim-core", Decidim::SurveysExtended::DECIDIM_VERSION
  spec.add_dependency "decidim-surveys", Decidim::SurveysExtended::DECIDIM_VERSION
  spec.add_dependency "decidim-forms", Decidim::SurveysExtended::DECIDIM_VERSION
end
