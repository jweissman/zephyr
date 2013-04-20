# tell rails how to find our ontology host
unless Rails.env.production?
  ENV['ZEPHYR_ONTOLOGY_HOST'] ||= `hostname`.chomp
  ENV['ZEPHYR_ONTOLOGY_PORT'] ||= 9000 # need this for prod (openshift has websockets on ports?)
  ENV['ZEPHYR_FIREHOSE_PORT'] ||= 7474
  ENV['ZEPHYR_FIREHOSE_HOST'] ||= `hostname`.chomp
end

Zephyr::Application.config.ontology_host = "#{ENV['ZEPHYR_ONTOLOGY_HOST']}:#{ENV['ZEPHYR_ONTOLOGY_PORT']}"
#if ENV['ZEPHYR_ONTOLOGY_PORT']
#  Zephyr::Application.config.ontology_host += ':' + ENV['ZEPHYR_ONTOLOGY_PORT']
#end

# TODO should probably split this apart into separate config -- or at least handled differently
#     (we'll ultimately have a separate service in prod...)
Zephyr::Application.config.firehose_host = "//#{ENV['ZEPHYR_FIREHOSE_HOST']}:#{ENV['ZEPHYR_FIREHOSE_PORT']}"
