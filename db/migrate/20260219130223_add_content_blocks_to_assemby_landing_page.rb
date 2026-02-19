class AddContentBlocksToAssembyLandingPage < ActiveRecord::Migration[7.0]
  def change
    Decidim::ContentBlock.where(scope_name: "assembly_homepage").destroy_all
    Decidim::Assembly.all.each do |assembly|
    block = Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "hero",
      weight: 1,
      published_at: Time.current
    )
    if block && assembly.hero_image&.attached?
      block.images_container.background_image.attach(assembly.hero_image.blob)
    end
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "extra_data",
      weight: 2,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "main_data",
      weight: 3,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "announcement",
      weight: 4,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "metadata",
      weight: 5,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "highlighted_posts",
      weight: 6,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "related_processes",
      weight: 7,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "related_assemblies",
      weight: 8,
      published_at: Time.current
    )

    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "highlighted_meetings",
      weight: 9,
      published_at: Time.current
    )

    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "highlighted_debates",
      weight: 10,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "highlighted_proposals",
      weight: 11,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "highlighted_results",
      weight: 12,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "related_documents",
      weight: 13,
      published_at: Time.current
    )
    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "related_images",
      weight: 14,
      published_at: Time.current
    )

    Decidim::ContentBlock.create(
      organization: assembly.organization,
      scope_name: "assembly_homepage",
      scoped_resource_id: assembly.id,
      manifest_name: "social_networks_metadata",
      weight: 15,
      published_at: Time.current
    )
    end
  end
end
