unless Rails.env.production?
  localhost, faye_port = 'localhost', '9292'
  ENV['ZEPHYR_FAYE_HOST']        ||= localhost
  ENV['ZEPHYR_FAYE_PORT']        ||= faye_port
  ENV['ZEPHYR_SECURE_FAYE_HOST'] ||= localhost
  ENV['ZEPHYR_SECURE_FAYE_PORT'] ||= faye_port
end

Zephyr::Application.config.faye_server        = "http://#{ENV['ZEPHYR_FAYE_HOST']}:#{ENV['ZEPHYR_FAYE_PORT']}/faye"
BackboneSync::Rails::Faye.root_address        = Zephyr::Application.config.faye_server
Zephyr::Application.config.faye_secure_server = Rails.env.production? ?
    "https://#{ENV['ZEPHYR_SECURE_FAYE_HOST']}:#{ENV['ZEPHYR_SECURE_FAYE_PORT']}/faye" :
    Zephyr::Application.config.faye_server
