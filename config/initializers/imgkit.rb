IMGKit.configure do |config|
  config.wkhtmltoimage = config.wkhtmltoimage = Rails.root.join('bin', 'wkhtmltoimage').to_s
  config.default_format = :png
end

