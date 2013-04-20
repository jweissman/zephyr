# Add firehose to a custom sprockets configuration.
my_sprockets_env = Sprockets::Environment.new
Firehose::Assets::Sprockets.configure my_sprockets_env
