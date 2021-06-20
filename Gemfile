# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = "0.24.3"

gem "decidim", DECIDIM_VERSION

# Deployment
gem 'mina'
gem 'sentry-raven'
gem 'slack-notifier'

# gem "puma", "~> 5.0"
gem 'puma', '= 5.3.2'
gem "uglifier", "~> 4.1"

gem "faker", "~> 2.14"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "bootsnap", "~> 1.4"
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
gem 'decidim-core-extended', path: 'decidim-core-extended'
gem 'decidim-processes-extended', path: 'decidim-processes-extended'
gem 'decidim-assemblies-extended', path: 'decidim-assemblies-extended'
