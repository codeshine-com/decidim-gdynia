# frozen_string_literal: true

Decidim::FilterFormBuilder.class_eval do

  def scopes_select(method, collection, options = {})
    fieldset_wrapper(options[:legend_title], "#{method}_scopes_select_filter") do
      super(method, collection, options)
    end
  end
end
