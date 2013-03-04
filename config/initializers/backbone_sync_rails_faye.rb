faye_host = Rails.env.production? ? "zephyrfaye-cerulean.rhcloud.com" : "localhost:9292"
BackboneSync::Rails::Faye.root_address = "http://#{faye_host}"
