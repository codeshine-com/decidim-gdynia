# frozen_string_literal: true

Decidim::ParticipatoryProcesses::ParticipatoryProcessPresenter.class_eval do
  private

  def contact
    "<p> #{process.contact_address} <br> #{process.contact_email} <br> #{process.contact_phone} </p>".html_safe
  end
end


