# frozen_string_literal: true

require "valid_email2"

module Decidim
  module Core
    module Extended
      class AuthorizationInhabitantCardForm < Form
        attribute :email
        attribute :card_number

        validates :email, presence: true, 'valid_email_2/email': { disposable: true }
        validates :card_number, presence: true
      end
    end
  end
end
