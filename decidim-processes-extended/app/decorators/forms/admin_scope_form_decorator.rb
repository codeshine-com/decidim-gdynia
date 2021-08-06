# frozen_string_literal: true

Decidim::Admin::ScopeForm.class_eval do
  
  attribute :promoted, GraphQL::Types::Boolean

end
