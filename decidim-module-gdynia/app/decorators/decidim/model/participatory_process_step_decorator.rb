# frozen_string_literal: true

Decidim::ParticipatoryProcessStep.class_eval do

  def can_participate?(step)
    false
  end

end
