{
  pl: {
    decidim: {
      forms: {
        file_validation: {
          allowed_file_extensions: lambda do |k, op|
            "Dozwolone rozszerzenia plików: #{op[:extensions].split(' ').join(', ')}."
          end
        }
      }
    }
  }
}
