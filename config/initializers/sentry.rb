# Raven.configure do |config|
#   config.dsn = ''
#   config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
#   config.environments = %w[ production staging ]
#   # config.excluded_exceptions += ['ActionController::RoutingError', 'ActiveRecord::RecordNotFound']
#   # Raven::Configuration::IGNORE_DEFAULT => ["AbstractController::ActionNotFound",
#   #                                          "ActionController::InvalidAuthenticityToken",
#   #                                          "ActionController::RoutingError", "ActionController::UnknownAction",
#   #                                          "ActiveRecord::RecordNotFound",
#   #                                          "CGI::Session::CookieStore::TamperedWithCookie",
#   #                                          "Mongoid::Errors::DocumentNotFound", "Sinatra::NotFound",
#   #                                          "ActiveJob::DeserializationError"]
# end