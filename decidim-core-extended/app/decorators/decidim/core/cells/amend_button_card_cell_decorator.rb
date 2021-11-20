# frozen_string_literal: true

Decidim::Amendable::AmendButtonCardCell.class_eval do

  def new_amend_help_text
    content_tag :small do
      t("help_text",
        scope: "decidim.amendments.amendable",
        model_name: model_name.downcase,
        amendable_fields: amendable_fields_to_sentence)
    end
  end

  def amendable_fields_to_sentence
    translated = []
    model.amendable_fields.each { |field|
      translated << t(field, scope: "activemodel.attributes.#{model.model_name.param_key.downcase}")
    }
    translated.to_sentence
  end

end
