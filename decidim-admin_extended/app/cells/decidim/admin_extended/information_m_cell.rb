# frozen_string_literal: true

module Decidim
  module AdminExtended
    # This cell renders the Medium (:m) post card
    # for an given instance of a Post
    class InformationMCell < Decidim::CardMCell
      include Rails.application.routes.mounted_helpers

      def show
        render :show
      end

      def resource_path
        model
      end

      def has_link_to_resource?
        false
      end

      # def data
      #   render :data
      # end

      def column_size_classes
        options[:column_size_classes]
      end

      private

      def description
        text = model.body

        decidim_sanitize(text)
      end

      def creation_date
        l(model.created_at.to_date, format: :decidim_short)
      end

      # used for displaying coauthorship in author cell, and for voting and other actions
      def has_actions?
        false
      end
    end
  end
end
