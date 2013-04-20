class Zephyr.Models.Enemy extends Backbone.Model
  initialize: =>
    console.log "--- new enemy created, subscribing..."
    ObjectHelper.addRole @, FirehoseConsumer
    @subscribe 'enemy', @get('id')
