# FIX missing required 'webpacker/version' in 2.7.0

WickedPdf::WickedPdfHelper::Assets.module_eval do
  def webpacker_version
    if defined?(Shakapacker)
      require 'shakapacker/version'
      Shakapacker::VERSION
    elsif defined?(Webpacker)
      require 'webpacker/version'
      Webpacker::VERSION
    end
  end
end


