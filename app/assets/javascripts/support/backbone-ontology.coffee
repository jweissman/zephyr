# i don't know how great or terrible this is, but i do think we need something like it for a unified model
# system across the client/server divide.
# i mean, ideally it's just a single zephyr 'model' which knows how to construct/generate
# appropriate backbone models; which might be able to be done on the fly. idk. thoughts.

#--- early thoughts
# i'm no longer sure this makes sense
# rpc duplex is good enough for communicating player input and pushing immediate 'de-structured' updates around
# but the real thing is to push the updates regularly from the world smoothly and integrate changes to front-end models seamlessly....
# (so the backbone-ontology adapter makes less sense in this context i think)


# === earlier thoughts
##close to needing this now :) it's really the other side of the firehose stuff -- pushing updates from the clients...
##not sure what the 'best' way to handle this is, given that client updates may have to be 'rolled back'
##i guess it would 'repair' itself after the update, but there might be a few turns until the 'fix' replaces old positions
##...more thought here :(
##
##SOON ENOUGH ..!!!!!
#
####
#Backbone Ontology Adapter
#Version 0.0.1
#
#  ( heavily inspired by https://raw.github.com/jeromegn/Backbone.localStorage/master/backbone.localStorage.js )
####
#((root, factory) ->
#  if typeof define is "function" and define.amd
#
#    # AMD. Register as an anonymous module.
#    define ["underscore", "backbone"], (_, Backbone) ->
#
#      # Use global variables if the locals are undefined.
#      factory _ or root._, Backbone or root.Backbone
#
#  else
#
#    # RequireJS isn't being used. Assume underscore and backbone are loaded in <script> tags
#    factory _, Backbone
#) this, (_, Backbone) ->
#
#  # A simple module to replace `Backbone.sync` with *localStorage*-based
#  # persistence. Models are given GUIDS, and saved into a JSON object. Simple
#  # as that.
#
#  # Hold reference to Underscore.js and Backbone.js in the closure in order
#  # to make things work even if they are removed from the global namespace
#
#  # Generate four random hex digits.
#  S4 = ->
#    (((1 + Math.random()) * 0x10000) | 0).toString(16).substring 1
#
#  # Generate a pseudo-GUID by concatenating random hexadecimal.
#  guid = ->
#    S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4()
#
##  Backbone.Ontology = window.Ontology = (model_id) ->
##    @ontology = new WebSocket("ws://#{window.OntologyHost}:#{window.OntologyPort}/ws")
##    @ontology.onopen    = (evt) => console.log "--- ONTOLOGY OPEN"
##    @ontology.onmessage = (evt) => console.log "--- ONTOLOGY MESSAGE!!"; console.log(evt)
##    @ontology.onclose   = (evt) => console.log "--- ONTOLOGY CLOSE"
##
#
#  Backbone.Firehose = window.Firehose = (model_name, collection) ->
##    @collection =
#    @firehose = new Firehose.Client()
#      .uri "//#{model_name}.json"
#      .message (msg) => collection.add(JSON.parse(msg))
#      .connect()
#
#
#
#
##   Backbone.LocalStorage = window.Store = (name) ->
#
#
##    @nickname = nickname
##    connection =
#
#
#  # Our Store is represented by a single JS object in *localStorage*. Create it
#  # with a meaningful name, like the name you'd give a table.
#  # window.Store is deprectated, use Backbone.LocalStorage instead
##  Backbone.LocalStorage = window.Store = (name) ->
##    @name = name
##    store = @localStorage().getItem(@name)
##    @records = (store and store.split(",")) or []
#
##    Backbone.Ontology = window.Ontology = (hostname, nickname)/
#
#  _.extend Backbone.Ontology::,
#
#    # Save the current state of the model to ontology -- localstorage...? ... **Store** to *localStorage*.
#           save: ->
##             @localStorage().setItem @name, @records.join(",")
#             @ontology.save()
#
#
#           # Add a model, giving it a (hopefully)-unique GUID, if it doesn't already
#           # have an id of it's own.
#           create: (model) ->
##             unless model.id
##               model.id = guid()
##               model.set model.idAttribute, model.id
##             @localStorage().setItem @name + "-" + model.id, JSON.stringify(model)
##             @records.push model.id.toString()
##             @save()
##             @find model
#
#
#           # Update a model by replacing its copy in `this.data`.
#           update: (model) ->
#             @localStorage().setItem @name + "-" + model.id, JSON.stringify(model)
#             @records.push model.id.toString()  unless _.include(@records, model.id.toString())
#             @save()
#             @find model
#
#
#           # Retrieve a model from `this.data` by id.
#           find: (model) ->
#             @jsonData @localStorage().getItem(@name + "-" + model.id)
#
#
#           # Return the array of all models currently in storage.
#
#           # return a list of 'entities' remotely...
#           findAll: ->
##             _(@records).chain().map((id) ->
##               @jsonData @localStorage().getItem(@name + "-" + id)
##             , this).compact().value()
#
#
#           # Delete a model from `this.data`, returning it.
#           destroy: (model) -> model
##             return false  if model.isNew()
##             @localStorage().removeItem @name + "-" + model.id
##             @records = _.reject(@records, (id) ->
##               id is model.id.toString()
##             )
##             @save()
##             model
#
##           localStorage: ->
##             localStorage
#
#
#           # fix for "illegal access" error on Android when JSON.parse is passed null
##           jsonData: (data) ->
##             data and JSON.parse(data)
#
#
#           # Clear localStorage for specific collection.
##           _clear: ->
##             local = @localStorage()
##             itemRe = new RegExp("^" + @name + "-")
##
##             # Remove id-tracking item (e.g., "foo").
##             local.removeItem @name
##
##             # Match all data items (e.g., "foo-ID") and remove.
##             _.chain(local).keys().filter((k) ->
##               itemRe.test k
##             ).each (k) ->
##               local.removeItem k
##
##
##
##           # Size of localStorage.
##           _storageSize: ->
##             @localStorage().length
#
#
#  # localSync delegate to the model or collection's
#  # *localStorage* property, which should be an instance of `Store`.
#  # window.Store.sync and Backbone.localSync is deprecated, use Backbone.LocalStorage.sync instead
#  Backbone.LocalStorage.sync = window.Store.sync = Backbone.localSync = (method, model, options) ->
#    store = model.localStorage or model.collection.localStorage
#    resp = undefined #If $ is having Deferred - use it.
#    errorMessage = undefined
#    syncDfd = $.Deferred and $.Deferred()
#    try
#      switch method
#        when "read"
#          resp = (if model.id isnt `undefined` then store.find(model) else store.findAll())
#        when "create"
#          resp = store.create(model)
#        when "update"
#          resp = store.update(model)
#        when "delete"
#          resp = store.destroy(model)
#    catch error
#      if error.code is DOMException.QUOTA_EXCEEDED_ERR and store._storageSize() is 0
#        errorMessage = "Private browsing is unsupported"
#      else
#        errorMessage = error.message
#    if resp
#      model.trigger "sync", model, resp, options
#      if options and options.success
#        if Backbone.VERSION is "0.9.10"
#          options.success model, resp, options
#        else
#          options.success resp
#      syncDfd.resolve resp  if syncDfd
#    else
#      errorMessage = (if errorMessage then errorMessage else "Record Not Found")
#      model.trigger "error", model, errorMessage, options
#      if options and options.error
#        if Backbone.VERSION is "0.9.10"
#          options.error model, errorMessage, options
#        else
#          options.error errorMessage
#      syncDfd.reject errorMessage  if syncDfd
#
#    # add compatibility with $.ajax
#    # always execute callback for success and error
#    options.complete resp  if options and options.complete
#    syncDfd and syncDfd.promise()
#
#  Backbone.ajaxSync = Backbone.sync
#  Backbone.getSyncMethod = (model) ->
#    return Backbone.localSync  if model.localStorage or (model.collection and model.collection.localStorage)
#    Backbone.ajaxSync
#
#
#  # Override 'Backbone.sync' to default to localSync,
#  # the original 'Backbone.sync' is still available in 'Backbone.ajaxSync'
#  Backbone.sync = (method, model, options) ->
#    Backbone.getSyncMethod(model).apply this, [method, model, options]
#
#  Backbone.LocalStorage
