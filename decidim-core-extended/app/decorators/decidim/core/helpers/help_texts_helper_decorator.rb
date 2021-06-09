Decidim::MetaTagsHelper.class_eval do
  def contact_us_by_mail_info
    tag.p class: 'help-text' do
      t("devise.contact_for_help_info", email: (mail_to 'konsultacje@lis.gdynia.pl', 'konsultacje@lis.gdynia.pl')).html_safe
    end
  end
end
