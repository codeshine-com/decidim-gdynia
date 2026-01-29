# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# DECIDIM_VERSION = "0.27.5"
# DECIDIM_VERSION = "0.28.6"
DECIDIM_VERSION = "0.29.1"

gem "decidim", DECIDIM_VERSION

# Deployment
# gem "bootsnap", "~> 1.4"
gem 'mina'
gem "sentry-ruby"
gem "sentry-rails"
gem 'slack-notifier'

gem 'puma'
gem 'http' # for InhabitantCardService
gem "uglifier", "~> 4.1"
gem "fog-aws"

gem "aws-sdk-s3", require: false

# FOR AWS ONLY
# ##################
# gem "nio4r", "2.5.8"

gem "faker"

gem "wicked_pdf"

gem 'dotenv-rails', group: [:development, :test, :staging]

gem 'sidekiq'
gem 'rexml'
gem 'awesome_print'

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "web-console", "~> 4.2"
end

group :production, :staging do
  gem 'rack_password'
end

# WAITING FOR MIGRATION:
# gem 'decidim-admin_extended', path: 'decidim-admin_extended'
# gem 'decidim-core-extended', path: 'decidim-core-extended'
# gem 'decidim-debates_extended', path: 'decidim-debates_extended'
# gem 'decidim-processes-extended', path: 'decidim-processes-extended'
# gem 'decidim-assemblies-extended', path: 'decidim-assemblies-extended'
# gem 'decidim-meetings_extended', path: 'decidim-module-meetings_extended'
# gem 'decidim-pages_extended', path: 'decidim-pages_extended'
# gem 'decidim-proposals_extended', path: 'decidim-proposals_extended'
# gem 'decidim-surveys_extended', path: 'decidim-surveys_extended'
