class Zephyr.Views.StarView extends Backbone.View
  star: (x,y) ->

    layer = @model.get('layer')
#    console.log "--- layer: #{layer}"
#    relativeX = atom.width/2 - (x+2-(atom.input.mouse.x/layer))
    relativeY = y - lastScrollY/(2*layer) #((layer/2))
    (new Molecular.Canvas.Ellipse(x,relativeY,
      radius: 2
      line_width: 0.2
      blur: 5
      stroke_style: 'white'
      fill_style: 'white'
      shadow_color: 'white'
      glowing: true
    )).inscribe()

  render: ->
    @star(@model.get('x'), @model.get('y'))




