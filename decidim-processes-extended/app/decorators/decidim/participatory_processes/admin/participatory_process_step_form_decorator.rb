# frozen_string_literal: true

Decidim::ParticipatoryProcesses::Admin::ParticipatoryProcessStepForm.class_eval do

  # turning off validations on date
  # clear_validators!
  # ATTENTION: after clearing validations check for changes in validations after upgrade!
  # decidim validations
  # validates :title, translatable_presence: true
  # validates :cta_path, format: { with: %r{\A[a-zA-Z]+[a-zA-Z0-9\-\_/]+\z} }, allow_blank: true

  _validators[:start_date]
    .find { |v| v.is_a? ::ActiveModel::Validations::DateValidator }
    &.attributes
    &.delete(:start_date)
  _validators[:end_date]
    .find { |v| v.is_a? ::ActiveModel::Validations::DateValidator }
    &.attributes
    &.delete(:end_date)

  # our validation
  validates :start_date, date: { before: :new_end_date, allow_blank: true, if: proc { |obj| obj.end_date.present? } }
  validates :end_date, date: { after: :new_start_date, allow_blank: true, if: proc { |obj| obj.start_date.present? } }

  def new_end_date
    end_date + 1.day
  end

  def new_start_date
    start_date - 1.day
  end
end
