# frozen_string_literal: true

Decidim::Admin::NewslettersController.class_eval do
  private

  def collection
    @collection ||= if current_user.admin?
                      Decidim::Newsletter.where(organization: current_organization)
                    else
                      Decidim::Newsletter.where(organization: current_organization).where(author_id: current_user.id)
                    end
  end
end