root = (exports ? this)

# generic uri behavior for keeping models and collection up-to-date
# hopefully relatively sane for most use cases
class root.FirehoseConsumer extends Mixin
  subscribe: (collection_name, instance_id) =>
    console.log "--- firehose consumer started for #{collection_name}"
    console.log "=== consuming instance #{instance_id} in particular" if instance_id
    @firehose_uri = "#{firehose_host}/#{collection_name}"
    @firehose_uri += "/#{instance_id}" if instance_id
    @firehose_uri += ".json"
    console.log "--- subscribing to updates from #{@firehose_uri}"
    @stream = new Firehose.Consumer
      message: (m) =>
        if instance_id
          @set(m)
        else
          # i kinda thought collection's #set handled the below
          # but #reset is a bit too intense (i get new elements!)...
          # and #set doesn't seem to handle new elements cleanly
          # n.b., i'm almost certainly missing something
          for instance in m
            entity = @get(instance['id'])
            if entity
              entity.set(instance)
            else
              @add(instance)
      uri: @firehose_uri
#    console.log "--- connecting firehose..."
    @stream.connect()

  # TODO actually use this when leaving worlds, etc.
  # (e.g., call a #deactivate to correspond with #activate.)
  unsubscribe: =>
    console.log "--- unsubscribe firehose...!!"
    @stream.stop()
