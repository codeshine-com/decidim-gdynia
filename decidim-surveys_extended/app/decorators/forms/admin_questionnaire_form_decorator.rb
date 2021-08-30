# frozen_string_literal: true

Decidim::Forms::Admin::QuestionnaireForm.class_eval do
  attribute :visible_for_unregistered, GraphQL::Types::Boolean
end
