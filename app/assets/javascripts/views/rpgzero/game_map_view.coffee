# got the idea to have a canvas view distinct from everything else, but it's really just a series of helpers for the
# world view...
class Zephyr.Views.GameMapView extends Backbone.View
  initialize: (options) =>

    console.log "==== game map view, model: "
    console.log @model

    console.log "--- players (in game_map_view#new)"

    console.log @model.get('players')

    console.log "--- enemies (in game_map_view#new)"
    console.log @model.get('enemies')


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
    @model.get('events').on 'add', (event) =>
      console.log "====== GOT AN EVENT"
      console.log event
      kind = event.get('kind')
      if kind == 'damage'
        console.log "=== hurray, you hit!"
        atom.playSound('sword')
      else if kind == 'attack_failed'
        console.log "=== aww, you missed!"
        atom.playSound('miss')
      else if kind == 'death'
        console.log "=== someone died!"

      console.log "--- i have played a sound maybe?"

      # adding a disappearing damage label and play an appropriate sound :)
#      console.log data


  clicked: (mouse) =>
    clicked_label = null
    _.map @labels, (label,label_name) =>
      if label.hit(mouse)
        clicked_label = label_name
    return clicked_label

  render: ->
    map = @model.get('rows')
#    console.log "=== GOT MAP: "
#    console.log map
#
    ts = 32
##    console.log "--- tile size: #{ts}"
##
    @tilemap(map,{tile_size:ts}) if map

#    console.log "--- handling labels..."
    _.each @labels, (label) => label.draw()

#    console.log "--- i have players: "
#    console.log @model.get('players')

    players = @model.get('players')
    unless !players || players.length == 0
#      console.log '--- the world should really have players! maybe the update is not here yet...?'
#    else
#      console.log "--- i've got players baby! here they are:"
#      console.log players
#      console.log "--- i have the following players: "
#      console.log players
#      for player in players
      players.each (player) =>
#        console.log "--- i have the following for a player: "
#        console.log player
        x  = (player.get('x')+1)*ts
        y  = (player.get('y')+1)*ts
        @sprites['warrior'].draw x,y
        new Canvas.Text(x,y+ts*2,{msg: "#{player.get('name')}!", fill_style: 'white', center: 'true'}).draw()
    enemies = @model.get('enemies')
#    console.log "--- about to render enemies!"
#    console.log enemies
    unless !enemies || enemies.length == 0
      enemies.each (enemy) =>
#        console.log enemy
        x = (enemy.get('x')+1)*ts
        y = (enemy.get('y')+1)*ts
        @sprites['skeleton'].draw x,y

        name = enemy.get("name")
        hp = enemy.get("hp")
        message = "#{name} [#{hp}]"
#        console.log "--- about to render message: #{message}"
        new Canvas.Text(x,y+ts*2,{
          msg: message
          fill_style: 'red'
          center: 'true'
        }).draw()

  dereferenceSprite: (code) ->
    switch code
      when 0 then @sprites['steel']
      else @sprites['floor']

  tilemap: (map, opts) ->
    # might make sense just to cache the map -- though hold off on this
    # first make it scrollable and cache large segments of it -- 256x256 or so i would think? (maybe bigger...)
    # for now it's fine :)
    # (the other side of that is clipping -- but again, for now it's fine. we're not even drawing big maps at all.)
    ts = opts['tile_size'] or 32
    sx = opts['x_offset']  or 0
    sy = opts['y_offset']  or 0

    for row, mapY in map
      for element, mapX in row
        x = (mapX+1) * ts
        y = (mapY+1) * ts
        sprite = @dereferenceSprite(element)
        sprite.draw(x+sx,y+sy)

# go ahead and handle assets here...?
$(document).ready ->
#  console.log "--- canvas view queuing assets...."
  Assets.queueDownload('floor.png')
  Assets.queueDownload('steel.png')
  Assets.queueDownload('warrior.png')
  Assets.queueDownload('skeleton.png')

#  Assets.queueDownload()




