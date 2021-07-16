Decidim::ProfileSidebarCell.class_eval do
  include Rails.application.routes.mounted_helpers

  def show
    render :new_show
  end
end
