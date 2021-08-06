# frozen_string_literal: true

Decidim::ApplicationHelper.class_eval do

  def edit_link(link_url, action, subject, extra_context = {}, link_options = { class: "topbar__edit__link" })
    return unless current_user
    return unless current_user.admin_terms_accepted?
    return unless admin_allowed_to?(action, subject, extra_context)
    return if content_for?(:edit_link)

    cell_html = raw(cell("decidim/navbar_admin_link", link_url: link_url, link_options: link_options))
    content_for(:edit_link, cell_html)
  end

end
