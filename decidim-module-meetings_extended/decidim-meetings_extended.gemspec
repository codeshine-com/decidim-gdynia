# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/meetings_extended/version"

Gem::Specification.new do |s|
  s.version = Decidim::MeetingsExtended.version
  s.authors = ["Paulina Kamińska"]
  s.email = ["paulina.kaminska@codeshine.com"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-meetings_extended"
  s.required_ruby_version = ">= 2.7"

  s.name = "decidim-meetings_extended"
  s.summary = "A decidim meetings_extended module"
  s.description = "Module exteding meetings."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::MeetingsExtended::DECIDIM_VERSION
end
