# frozen_string_literal: true

Decidim::Surveys::Admin::SurveyForm.class_eval do
  attribute :visible_for_unregistered, GraphQL::Types::Boolean
end
