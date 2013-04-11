
root = (exports ? this)
class root.Ontology
  constructor: (@host, @port, @player_id, @player_name) -> #, @username) ->
    unless "WebSocket" of window
      alert "We're sorry, but WebSockets are not available in this browser."
      return
    @ws = new WebSocket("ws://#{@host}:#{@port}/ws")
    @ws.onopen    = (evt) => @handleOpen()
    @ws.onmessage = (evt) => @handleMessage(evt)
    @ws.onclose   = (evt) => @handleClose()
    @callbacks = {}

  handleClose: ->
    console.log "--- WEBSOCKET CLOSED (!!!)"

  handleOpen: => @ping()

  ping: =>
    console.log "--- PING (hello from #{player_name}!)"
    @sendCommand("ping")

  join: (world_id) => #(user_id, user_name) =>
    console.log "--- JOIN WORLD #{world_id}"
    @sendCommand("join", {world_id: world_id})

  leave: =>
    console.log "=== LEAVE!"
    @sendCommand("leave")

  create: (world_name) =>
    console.log "--- CREATE WORLD #{world_name}"
    @sendCommand("create", {world_name: world_name})

  chat: (msg) ->
    console.log "--- CHAT #{msg}"
    @sendCommand("chat", {message: msg})

  move: (direction) ->
    console.log "--- MOVE #{direction}"
    @sendCommand("move", {direction: direction})

#  bye:  ->
#    console.log "--- BYE!"
#    @sendCommand("bye")

  on: (evt,cb) ->
    console.log "--- callback registered: #{evt}"
    @callbacks[evt] = @callbacks[evt] or= []
    @callbacks[evt].push(cb)

  handleMessage: (msg) ->
    console.log "==== HANDLE MESSAGE"
    console.log msg
    try
      data = JSON.parse(msg.data)
      for cb in @callbacks[data['command']]
        cb(data)
    catch error
      console.log "--- encountering an error attempting to parse websocket message: "
      console.log msg

  sendCommand: (cmd, opts) =>
    base_command_elements = {command: cmd, player_id: @player_id, player_name: @player_name}
    assembled_command = $.extend({},base_command_elements,opts)
    stringified_command = JSON.stringify(assembled_command)
    console.log stringified_command
    @xmit stringified_command

  xmit: (msg) ->
    try
      @ws.send msg # stringified_command
    catch error
      console.log "Error sending websocket message: #{error}"

    true

$(document).ready ->
  console.log "=== ontology client establishing connection..."
  if ontology_host?
    console.log "--- establishing connection to ontology host / not joining!"
    window.ontology = new Ontology(ontology_host,9000,player_id,player_name)

