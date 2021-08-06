# frozen_string_literal: true

Decidim::Admin::CreateStaticPageTopic.class_eval do

  def call
    return broadcast(:invalid) if @form.invalid?

    @topic = Decidim.traceability.create!(
      StaticPageTopic,
      @form.current_user,
      title: @form.title,
      description: @form.description,
      organization: @form.current_organization,
      show_in_footer: @form.show_in_footer,
      weight: @form.weight,
      # custom
      cover: form.cover.presence || nil
    )
    broadcast(:ok)
  end
end
