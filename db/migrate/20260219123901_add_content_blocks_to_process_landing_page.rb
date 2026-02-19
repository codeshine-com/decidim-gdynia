class AddContentBlocksToProcessLandingPage < ActiveRecord::Migration[7.0]
  # Migration only for prepare existing participatory processes 'home page' after migration from older versions
  def up
    Decidim::ContentBlock.where(scope_name: "participatory_process_homepage").destroy_all


    Decidim::ParticipatoryProcess.all.each do |process|
      block = Decidim::ContentBlock.find_or_create_by(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "hero",
        weight: 1
      )
      if block && process.hero_image&.attached?
        block.images_container.background_image.attach(process.hero_image.blob)
      end
      block.update(published_at: Time.current)

      extra_data = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "extra_data",
        weight: 2
      )
      extra_data.update(published_at: Time.current)

      main_data = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "main_data",
        weight: 2
      )
      main_data.update(published_at: Time.current)
      announcement = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "announcement",
        weight: 3
      )
      announcement.update(published_at: Time.current)

      metadata = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "metadata",
        weight: 4,
        )
      metadata.update(published_at: Time.current)

      highlighted_posts = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "highlighted_posts",
        weight: 5
      )
      highlighted_posts.update(published_at: Time.current)


      related_processes = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "related_processes",
        weight: 6
      )
      related_processes.update(published_at: Time.current)

      related_assemblies = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "related_assemblies",
        weight: 7
      )
      related_assemblies.update(published_at: Time.current)

      highlighted_meetings = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "highlighted_meetings",
        weight: 8
      )
      highlighted_meetings.update(published_at: Time.current)

      highlighted_debates = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "highlighted_debates",
        weight: 9
      )
      highlighted_debates.update(published_at: Time.current)

      highlighted_proposals = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "highlighted_proposals",
        weight: 10
      )
      highlighted_proposals.update(published_at: Time.current)

      highlighted_results = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "highlighted_results",
        weight: 11
      )
      highlighted_results.update(published_at: Time.current)

      related_images = Decidim::ContentBlock.find_or_create_by!(
        organization: process.organization,
        scope_name: "participatory_process_homepage",
        scoped_resource_id: process.id,
        manifest_name: "related_images",
        weight: 11
      )
      related_images.update(published_at: Time.current)

    end
  end

  def down; end
end
