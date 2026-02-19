# frozen_string_literal: true

require "valid_email2"

module Decidim
  module Gdynia
    class AuthorizationInhabitantCardForm < Form
      include Decidim::Gdynia::ApplicationHelper

      attribute :email
      attribute :card_number

      validates :email, presence: true, "valid_email_2/email": { disposable: true }
      validates :card_number, presence: true

      validate :card_number_uniqie?
    end
  end
end
