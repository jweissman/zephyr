window.BackboneFactory =
  factories: {}
  sequences: {}
  define: (factory_name, klass, defaults) ->

    # Check for arguments' sanity
    throw "Factory name should not contain spaces or other funky characters"  if factory_name.match(/[^\w_]+/)
    if defaults is `undefined`
      defaults = ->
        {}

    # The object creator
    @factories[factory_name] = (options) ->
      if options is `undefined`
        options = ->
          {}
      arguments_ = _.extend({},
                            id: BackboneFactory.next("_" + factory_name + "_id")
      , defaults.call(), options.call())
      new klass(arguments_)


    # Lets define a sequence for id
    BackboneFactory.define_sequence "_" + factory_name + "_id", (n) ->
      n


  create: (factory_name, options) ->
    throw "Factory with name " + factory_name + " does not exist"  if @factories[factory_name] is `undefined`
    @factories[factory_name].apply null, [options]

  define_sequence: (sequence_name, callback) ->
    @sequences[sequence_name] = {}
    @sequences[sequence_name]["counter"] = 0
    @sequences[sequence_name]["callback"] = callback

  next: (sequence_name) ->
    throw "Sequence with name " + sequence_name + " does not exist"  if @sequences[sequence_name] is `undefined`
    @sequences[sequence_name]["counter"] += 1
    @sequences[sequence_name]["callback"].apply null, [@sequences[sequence_name]["counter"]] #= callback;
