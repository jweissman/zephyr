# got the idea to have a canvas view distinct from everything else, but it's really just a series of helpers for the
# world view...
class Zephyr.Views.CanvasView extends Backbone.View
  initialize: (@world) =>
    console.log "=== initializing canvas view...!!!"
    #    @world = opts['world']

    ####################################################################################################################
    ## REMEMBER TO ADD THE NEW SPRITE TO MANIFEST AT THE BOTTOM OF THE PAGE
    ## OR YOU WILL NOT BE DISPLAYING YOUR NEW SPRITE TODAY!
    ## ALSO MAKE SURE YOU HAVE ACTUALLY HAVE PUT AN UNDERLYING IMAGE INTO public/assets (!)
    ####################################################################################################################


    @sprites = {
      'steel':   new Canvas.Image(Assets.getAsset('steel.png'))
      'floor':   new Canvas.Image(Assets.getAsset('floor.png'))
      'warrior': new Canvas.Image(Assets.getAsset('warrior.png'))
    #
    #  'archer':  new Canvas.Image...
    #  'treasure'...
    #  'monster'...
    #
    }

    @labels = {
      'exit': new Canvas.Text(640,300,{msg: "Leave Realm Now!"})
    }

  clicked: (mouse) =>
    console.log "--- canvas view clicked!!!"
    _.map @labels, (label,label_name) =>
      console.log "--- considering whether label #{label_name} was hit at #{mouse.x}, #{mouse.y}"
      if label.hit(mouse)
#        console.log "--- label clicked: "
#        console.log label
        if label_name == 'exit'
          console.log "--- user clicked leave! guess we're doing it..."
          ontology.leave()
          window.GameState = window.GameStates.WorldSelection

  render: ->
    console.log '--- rendering canvas!'

    map = @world.get('map')
    console.log "=== GOT MAP: "
    console.log map

    ts = @world.get('tile_size') or 32
    console.log "--- tile size: #{ts}"

    @tilemap(map,{tile_size:ts}) if map

    console.log "--- handling labels..."
    _.each @labels, (label) =>
      console.log "--- attempting to draw label..."
      label.draw()

    players = @world.get('players')
    for player in players
      x  = player.get('x')
      y  = player.get('y')
      @sprites['warrior'].draw x*ts, y*ts

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
  console.log "--- canvas view queuing assets...."
  Assets.queueDownload('floor.png')
  Assets.queueDownload('steel.png')
  Assets.queueDownload('warrior.png')

#  Assets.queueDownload()




