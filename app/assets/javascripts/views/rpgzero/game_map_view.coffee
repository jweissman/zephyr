# got the idea to have a canvas view distinct from everything else, but it's really just a series of helpers for the
# world view...
class Zephyr.Views.GameMapView extends Backbone.View
  initialize: (options) =>

    @tile_size = 32
    @x_offset = 1
    @y_offset = 1

    console.log "==== game map view, model: "
    console.log @model

    console.log "--- players (in game_map_view#new)"

    console.log @model.get('players')

#    console.log "--- enemies (in game_map_view#new)"
#    console.log @model.get('enemies')


    ####################################################################################################################
    ## REMEMBER TO ADD THE NEW SPRITE TO MANIFEST AT THE BOTTOM OF THE PAGE
    ## OR YOU WILL NOT BE DISPLAYING YOUR NEW SPRITE TODAY!
    ## ALSO MAKE SURE YOU HAVE ACTUALLY HAVE PUT AN UNDERLYING IMAGE INTO public/assets (!)
    ####################################################################################################################

    @sprites = {
      'steel':    new Canvas.Image(Assets.getAsset('steel.png'))
      'floor':    new Canvas.Image(Assets.getAsset('floor.png'))
      'warrior':  new Canvas.Image(Assets.getAsset('warrior.png'))
      'skeleton': new Canvas.Image(Assets.getAsset('skeleton.png'))
    #
    #  'archer':  new Canvas.Image...
    #  'treasure'...
    #  'monster'...
    #
    }

    @labels = {
      'exit': new Canvas.Text(940,300,{msg: "Leave Realm Now!"})
    }

    # bind to events? it could just emit a custom event and i could pick it up
    # but i figured simplest possible thing to check if we can get this working :)
#    @model.get('events').on 'add', (event) =>
    ontology.on 'game_event', (event) =>
      console.log "====== GOT A GAME EVENT (via websockets now!)"
      console.log event
      kind = event['kind']
      if kind == 'damage'
        console.log "=== hurray, you hit!"
        atom.playSound('sword')
      else if kind == 'attack_failed'
        console.log "=== aww, you missed!"
        atom.playSound('miss')
      else if kind == 'death'
        console.log "=== someone died!"
        # actually need to update the local entity here now :/
        # although the update should have come from firehose... :/
        # apparently can't rely on for data services? what is going on with this?

        atom.playSound('sword') # TODO use a different sound for death
      else if kind == 'movement'
        console.log "=== someone moved!"
        details = event['details']
        uuid = details['uuid']
        console.log "--- got move event uuid: #{uuid}"
        if ontology.sentEvent(uuid)
          console.log "--- this client sent this move, ignoring...**************"
        else
          console.log "--- another client sent this move....**********"
          player_id = details['player_id']
          x = details['x']
          y = details['y']
          console.log "--- some other client moved to #{x}, #{y}!"
          console.log "processing move for player #{player_id}..."
          moving_player = @model.get('players').get(player_id)
          console.log "=== moving player #{player_id}"
          moving_player.set({x:x,y:y})
          console.log "--- player #{moving_player.get('name')} moved to #{x}, #{y}!"
      else
        console.log "=== i don't understand event type '#{kind}'"
      console.log "--- done processing event receipt..."

  clicked: (mouse) =>
    clicked_label = null
    _.map @labels, (label,label_name) =>
      if label.hit(mouse)
        clicked_label = label_name
    return clicked_label

  current_player: =>
    @model.current_player()


  render: =>
    user = @model.current_player()
    if user
      screen_center_x = atom.width / 2
      screen_center_y = atom.height / 2
      @x_offset = (screen_center_x/32) - user.get('x')
      @y_offset = (screen_center_y/32) - user.get('y')
    else
      @x_offset = 1
      @y_offset = 1

    map = @model.get('rows')
    ts = 32
    @tilemap(map,{tile_size:ts}) if map

    _.each @labels, (label) => label.draw()

    players = @model.get('players')
    unless !players || players.length == 0
      players.each (player) =>
        x  = (player.get('x')+@x_offset)*ts
        y  = (player.get('y')+@y_offset)*ts
        @sprites['warrior'].draw x,y
        new Canvas.Text(x,y+ts*2,{msg: "#{player.get('name')} [#{player.get('hp')}] (#{player.get('x')},#{player.get('y')})", fill_style: 'white', center: 'true'}).draw()

    enemies = @model.get('enemies')
    unless !enemies || enemies.length == 0
      enemies.each (enemy) =>
        x = (enemy.get('x')+@x_offset)*ts
        y = (enemy.get('y')+@y_offset)*ts
        @sprites['skeleton'].draw x,y

        name = enemy.get("name")
        hp = enemy.get("hp")
        message = "#{name} [#{hp}]"
        new Canvas.Text(x,y+ts*2,{
          msg: message
          fill_style: 'red'
          center: 'true'
        }).draw()

  dereferenceSprite: (code) ->
    switch code
      when 0 then @sprites['steel']
      else @sprites['floor']

  tilemap: (map) ->
    ts = @tile_size
    sx = @x_offset
    sy = @y_offset

    for row, mapY in map
      for element, mapX in row
        x = (mapX+sx) * ts
        y = (mapY+sy) * ts
        # TODO if real x,y is even on the screen...
        sprite = @dereferenceSprite(element)
        sprite.draw(x,y)

# go ahead and handle assets here...?
$(document).ready ->
  Assets.queueDownload('floor.png')
  Assets.queueDownload('steel.png')
  Assets.queueDownload('warrior.png')
  Assets.queueDownload('skeleton.png')



