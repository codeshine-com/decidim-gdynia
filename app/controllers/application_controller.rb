class ApplicationController < ActionController::Base
  before_action :set_raven_context

  private

  def set_raven_context
    return unless Rails.application.secrets.sentry_enabled?

    Raven.user_context(id: session[:user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
