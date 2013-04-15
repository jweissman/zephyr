class Zephyr.Collections.Enemies extends Backbone.Collection
  initialize: (models, options) =>
    if options && options.world_id
      enemies_uri = "world/#{options.world_id}/enemies"
      ObjectHelper.addRole @, FirehoseConsumer
      @subscribe enemies_uri
