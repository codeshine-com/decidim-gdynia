Decidim::Admin::AttachmentCollectionForm.class_eval do
  clear_validators!
  # removing only :description presence validation
  validates :name, translatable_presence: true
end
