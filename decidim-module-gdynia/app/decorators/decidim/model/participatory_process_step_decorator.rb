# frozen_string_literal: true

Decidim::ParticipatoryProcessStep.class_eval do
  #fix for bug on update to v030
  def can_participate?(step)
    false
  end

end
