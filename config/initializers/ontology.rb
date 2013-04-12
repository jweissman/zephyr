# tell rails how to find our ontology host
ENV['ZEPHYR_ONTOLOGY_HOST'] ||= 'localhost' unless Rails.env.production?
Zephyr::Application.config.ontology_host = "#{ENV['ZEPHYR_ONTOLOGY_HOST']}"

# TODO should probably split this apart into separate config -- or at least handled differently
#     (we'll ultimately have a separate service in prod...)
Zephyr::Application.config.firehose_host = "//#{ENV['ZEPHYR_ONTOLOGY_HOST']}:7474"
