root = (exports ? this)
class root.Ontology
  constructor: (@host, @port, @username) ->
    unless "WebSocket" of window
      alert "We're sorry, but WebSockets are not available in this browser."
      return
    @ws = new WebSocket("ws://#{@host}:#{@port}/ws")
    @ws.onopen    = (evt) => @handleOpen()
    @ws.onmessage = (evt) => @handleMessage(evt)
    @ws.onclose   = (evt) => @handleClose()

    @callbacks = {}

  handleClose: -> @bye()
  handleOpen: => @join()

  join: =>
    console.log "--- JOIN"
    @sendCommand("join")

  chat: (msg) ->
    console.log "--- CHAT"
    @sendCommand("chat", {message: msg})

  move: (direction) ->
    console.log "--- MOVE"
    @sendCommand("move", {direction: direction})

  bye:  ->
    console.log "--- BYE!"
    @sendCommand("bye")

  on: (evt,cb) ->
    console.log "--- callback registered: #{evt}"
    @callbacks[evt] = @callbacks[evt] or= []
    @callbacks[evt].push(cb)

  handleMessage: (msg) ->
    try
      data = JSON.parse(msg.data)
      for cb in @callbacks[data['command']]
        cb(data)
    catch error
      console.log "--- encountering an error attempting to parse websocket message: #{msg}"

  sendCommand: (cmd, opts) =>
    base_command_elements = {command: cmd, user: @username}
    assembled_command = $.extend({},base_command_elements,opts)

    console.log "--- would be sending assembled command: "
    console.log assembled_command

    stringified_command = JSON.stringify(assembled_command)
#    @ws.send(JSON.stringify(assembled_command))

    console.log stringified_command
    @xmit stringified_command

  xmit: (msg) ->
    try
      @ws.send msg # stringified_command
    catch error
      console.log "Error sending websocket message: #{error}"
    #    finally


    true

