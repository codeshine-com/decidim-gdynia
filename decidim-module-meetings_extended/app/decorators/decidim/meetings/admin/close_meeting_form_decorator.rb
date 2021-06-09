Decidim::Meetings::Admin::CloseMeetingForm.class_eval do

  _validators[:attending_organizations]
    .find { |v| v.is_a? ::ActiveModel::Validations::PresenceValidator }
    &.attributes
    &.delete(:attending_organizations)

  _validators.reject! { |key, _| key == :attending_organizations }
  _validators.each do |key, _|
    _[0].attributes.delete(:attending_organizations) if _[0].attributes.include?(:attending_organizations)
  end

end
