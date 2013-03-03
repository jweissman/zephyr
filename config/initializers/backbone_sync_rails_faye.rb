faye_host = Rails.env.production? ? "zephyr-faye.herokuapp.com" : "localhost:9292"
BackboneSync::Rails::Faye.root_address = "http://#{faye_host}"
