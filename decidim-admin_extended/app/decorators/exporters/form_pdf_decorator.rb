# frozen_string_literal: true

Decidim::Exporters::FormPDF.class_eval do
  def template
    "decidim/forms/admin/questionnaires/answers/export/pdf_new"
  end
end