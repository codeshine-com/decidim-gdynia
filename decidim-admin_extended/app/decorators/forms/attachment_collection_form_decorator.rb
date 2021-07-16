Decidim::Admin::AttachmentCollectionForm.class_eval do
  clear_validators!
  validates :name, translatable_presence: true
end
