faye_host = "zephyrFayeDiy-cerulean.rhcloud.com/faye" # Rails.env.production? ? "zephyrfaye-cerulean.rhcloud.com" : "zephyrfaye-cerulean.rhcloud.com:8000"
BackboneSync::Rails::Faye.root_address = "https://#{faye_host}"
