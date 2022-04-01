Decidim::Admin::AttachmentForm.class_eval do
  clear_validators!
  # removing only :description presence validation
  validates :file, presence: true, unless: :persisted?
  validates :file, passthru: { to: Decidim::Attachment }
  validates :title, translatable_presence: true
  validates :attachment_collection, presence: true, if: ->(form) { form.attachment_collection_id.present? }
  validates :attachment_collection_id, inclusion: { in: :attachment_collection_ids }, allow_blank: true
end
