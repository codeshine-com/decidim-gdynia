# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = "0.24.3"

gem "decidim", DECIDIM_VERSION

# Deployment
# gem "bootsnap", "~> 1.4"
gem 'mina'
gem 'sentry-raven'
gem 'slack-notifier'

gem 'puma', '= 5.3.2'
gem "uglifier", "~> 4.1"
gem "fog-aws"

gem "faker", "~> 2.14"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end

group :production, :staging do
  gem 'rack_password'
end

# extended functionalities
gem 'decidim-admin_extended', path: 'decidim-admin_extended'
gem 'decidim-core-extended', path: 'decidim-core-extended'
gem 'decidim-debates_extended', path: 'decidim-debates_extended'
gem 'decidim-processes-extended', path: 'decidim-processes-extended'
gem 'decidim-assemblies-extended', path: 'decidim-assemblies-extended'
gem 'decidim-meetings_extended', path: 'decidim-module-meetings_extended'
gem 'decidim-pages_extended', path: 'decidim-pages_extended'
gem 'decidim-proposals_extended', path: 'decidim-proposals_extended'
gem 'decidim-surveys_extended', path: 'decidim-surveys_extended'
