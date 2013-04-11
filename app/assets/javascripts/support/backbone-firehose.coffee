root = (exports ? this)

# generic uri behavior for keeping models and collection up-to-date
# hopefully relatively sane for most use cases
class root.FirehoseConsumer extends Mixin
  subscribe: (collection_name, instance_id) =>

    @firehose_uri = "#{firehose_host}/#{collection_name}"
    @firehose_uri += "/#{instance_id}" if instance_id
    @firehose_uri += ".json"

    # old collections keep clobbering newer instance data...
    # are we sending out old stuff?

    # we're creating a million of these, wtf!
    @stream = new Firehose.Consumer
      message: (m) =>
        console.log "--- firehose consumer!"
#        console.log "=== what i am: "
#        console.log @
#        console.log "=== what i'm setting: "
#        console.log m
#        @each (m) => m.unlink()
        if instance_id
          @set(m)
        else
          console.log "--- firehose collection consumer... processing update"
          console.log m
          for instance in m
            console.log "--- firehose collection handling instance: "
            console.log instance
            console.log "--- attempting to lookup entity"
            entity = @get(instance['id'])
            if entity
              console.log "--- existing entity, setting model..."
              console.log entity
              entity.set(instance)
#              @set([entity])
              console.log "--- after set..."
              console.log entity
            else
              console.log "--- new entity, adding model..."
              @add(instance)
      uri: @firehose_uri
    @stream.connect()

  unsubscribe: => @stream.stop()
