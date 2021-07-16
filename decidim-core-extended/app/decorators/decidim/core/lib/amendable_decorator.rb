Decidim::Amendable.class_eval do

  def amendable_fields
    self.class.amendable_options[:fields].map { |field|
      I18n.t("decidim.amendable.fields.#{field}")
    }
  end

end
