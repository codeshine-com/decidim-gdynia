# frozen_string_literal: true

Decidim::Assemblies::AssemblyPresenter.class_eval do
      def contact
        "<p> #{assembly.contact_address} <br> #{assembly.contact_email} <br> #{assembly.contact_phone} </p>".html_safe
      end
      end
