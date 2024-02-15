#
# Do zmigrowania wystarczy uruchomic kolejno rzeczy w konsoli
#

MIGRATION_ATTRIBUTES = {
  "Decidim::Area" => lambda do
    [
      [Decidim::Area, "icon", Decidim::Cw::ImageUploader, "icon"]
    ]
  end,
  "Decidim::AssemblyMember" => lambda do
    [
      [Decidim::AssemblyMember, "avatar", Decidim::Cw::AvatarUploader, "avatar"]
    ]
  end,
  "Decidim::Forms::Question" => lambda do
    [
      [Decidim::Forms::Question, "question_image", Decidim::Cw::ImageUploader, "question_image"]
    ]
  end,
  "Decidim::StaticPageTopic" => lambda do
    [
      [Decidim::StaticPageTopic, "cover", Decidim::Cw::BannerImageUploader, "cover"]
    ]
  end
}.sum do |main_model, attributes|
  main_model.constantize.is_a?(Class) ? attributes.call : []
rescue NameError
  []
end.freeze

def migrate
  logger = ActiveSupport::TaggedLogging.new(Logger.new("log/#{Time.current.strftime("%Y%m%d%H%M")}_activestorage_migration.log"))
  routes_mappings = []

  MIGRATION_ATTRIBUTES.each do |(klass, cw_attribute, cw_uploader, as_attribute)|
    Decidim::CarrierWaveMigratorService.migrate_attachment!({
                                                              klass: klass, cw_attribute: cw_attribute,
                                                              cw_uploader: cw_uploader, as_attribute: as_attribute,
                                                              logger: logger,
                                                              routes_mappings: routes_mappings
                                                            })
  end
end