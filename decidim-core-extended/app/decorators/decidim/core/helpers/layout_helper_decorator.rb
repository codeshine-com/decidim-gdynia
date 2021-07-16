Decidim::LayoutHelper.class_eval do

  def extended_navigation_bar(items, max_items: 5)
    return unless items.any?

    extra_items = items.slice((max_items + 1)..-1) || []
    active_item = items.find { |item| item[:active] if item }

    render partial: "decidim/shared/extended_navigation_bar", locals: {
      items: items,
      extra_items: extra_items,
      active_item: active_item,
      max_items: max_items
    }
  end

end
