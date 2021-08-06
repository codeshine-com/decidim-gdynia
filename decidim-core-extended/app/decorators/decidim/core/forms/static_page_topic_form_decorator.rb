# frozen_string_literal: true

Decidim::Admin::StaticPageTopicForm.class_eval do
  include Decidim::HasUploadValidations

  attribute :cover
  attribute :remove_cover
end
