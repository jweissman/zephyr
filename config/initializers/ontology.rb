# tell rails how to find our ontology host
ENV['ZEPHYR_ONTOLOGY_HOST'] ||= `hostname`.chomp unless Rails.env.production?
Zephyr::Application.config.ontology_host = "#{ENV['ZEPHYR_ONTOLOGY_HOST']}"
