Decidim::AttachmentCreatedEvent.class_eval do

  def resource_text
    translated_attribute(
      @resource.try(:description) ||
        @resource.try(:body)
    )
  end
end
