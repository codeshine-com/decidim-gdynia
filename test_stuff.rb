# Pobranie PDF z ankiet
# https://konsultujemy.gdynia.pl/admin/participatory_processes/zmianaGPR/components/32/exports.FormPDF?id=survey_user_answers?resource_id=19

current_user = user =  Decidim::User.first
component = Decidim::Component.find(32)
name = 'survey_user_answers'
format = 'FormPDF'
resource_id = 19

export_manifest = component.manifest.export_manifests.find do |manifest|
  manifest.name == name.to_sym
end
collection = nil
1.tap { collection = export_manifest.collection.call(component, user, resource_id) }
serializer = export_manifest.serializer
export_data = Decidim::Exporters.find_exporter(format).new(collection, serializer).export
ExportMailer.export(user, name, export_data).deliver_now

# Katalog aplikacji: /var/app/current
# Katalog wkhtmltopdf: /var/app/current/vendor/bundle/ruby/2.7.0/gems/wkhtmltopdf-binary-0.12.6.5/bin/wkhtmltopdf_centos_7_amd64
#
#
# -- dodanie brakujacej binarki i uprawnien - bo normalnie sa wszystkie jako root a nie webapp
# sudo su -
# cd /var/app/current/vendor
# chown -R webapp:webapp bundle
# cd /var/app/current/vendor/bundle/ruby/2.7.0/gems/wkhtmltopdf-binary-0.12.6.5/bin
# gzip -dc wkhtmltopdf_centos_7_amd64.gz > wkhtmltopdf_centos_7_amd64
# chown webapp:webapp wkhtmltopdf_centos_7_amd64
# chmod 755 wkhtmltopdf_centos_7_amd64
