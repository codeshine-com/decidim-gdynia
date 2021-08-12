# frozen_string_literal: true

Decidim::ParticipatoryProcessStep.class_eval do

  # turning off validations on date
  # clear_validators!
  # ATTENTION: after clearing validations check for changes in validations after upgrade!
  # decidim validations
  # validates :active, uniqueness: { scope: :decidim_participatory_process_id }, if: proc { |step| step.active? }

  # validates :position, numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_blank: true
  # validates :position, uniqueness: { scope: :decidim_participatory_process_id }

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
