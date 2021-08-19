# frozen_string_literal: true

Decidim::Assemblies::AssemblyMembersController .class_eval do
  before_action :cadencies, only: :index

  private

  def members
    if all_cadencies.any?
      @members ||= all_cadencies.first.members.not_ceased
    else
      @members ||= current_participatory_space.members.not_ceased
    end
  end

  def all_cadencies
    @all_cadencies ||= current_participatory_space.cadencies&.order('weight DESC')
  end

  def cadencies
    @cadencies = all_cadencies[1..-1]
  end

end
