# frozen_string_literal: true

require "http"

module Decidim
  module Gdynia
    class InhabitantCardService
      def initialize(form)
        @card_number = form.card_number
        @email = form.email
      end

      def call
        return false unless card_number.present? && email.present?

        card_owner_with_valid_email?
      end

      private

      attr_reader :card_number, :email

      def card_owner_with_valid_email?
        card_owner_email_validation_request["success"]
      end

      def card_owner_email_validation_request
        ctx = OpenSSL::SSL::SSLContext.new
        ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
        response = HTTP.post(
          ENV.fetch('KARTA_MIEJSKA_API_URL'),
          form: {
            token: ENV.fetch('KARTA_MIEJSKA_API_TOKEN'),
            card_number: card_number,
            owner_email: email
          },
          ssl_context: ctx
        )
        JSON.parse response.to_s # => {"success"=>true, "err"=>"", "errno"=>0}
      end
    end
  end
end
