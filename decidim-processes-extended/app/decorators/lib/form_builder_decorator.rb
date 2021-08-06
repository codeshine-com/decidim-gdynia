# frozen_string_literal: true

Decidim::FormBuilder.class_eval do

  def scopes_collection_select(name, collection, selected = nil, disabled = nil, options = {}, html_options = {})
    selected = object.send(name)
    selected = selected.first if selected.is_a?(Array) && selected.length > 1
    select(name, @template.options_for_select(collection, selected: selected, disabled: disabled), options, html_options)
  end

  def scopes_select(name, collection, options = {}, html_options = {})
      selectables = if collection.first.is_a?(Decidim::Scope)
                      scopes = collection
                                   .map { |s| [s.name[I18n.locale.to_s], s.id] }
                                   .sort_by { |arr| arr[0] }

                      @template.options_for_select(
                        scopes,
                        selected: options[:selected]
                      )
                    else
                      @template.option_groups_from_collection_for_select(
                        collection,
                        :scopes,
                        :translated_name,
                        :id,
                        :translated_name,
                        selected: options[:selected]
                      )
                    end

      select(name, selectables, options, html_options.merge({ multiple: options[:multiple], class: options[:multiple] ? 'scopes-expanded' : nil }))
    end
end
