# frozen_string_literal: true

Decidim::Proposals::CollaborativeDraftsController.class_eval do

  private

  # Available orders based on enabled settings
  def available_orders
    @available_orders ||= begin
      available_orders = %w(random recent)
      available_orders
    end
  end

  def default_order
    detect_order("recent")
  end

  def reorder(drafts)
    case order
    when "random"
      drafts.order_randomly(random_seed)
    when "recent"
      drafts.order(created_at: :desc)
    end
  end
end
