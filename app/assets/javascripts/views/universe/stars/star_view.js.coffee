class Zephyr.Views.StarView extends Backbone.View
  @absoluteToRelativeY: (y,layer) -> y + (lastScrollY/(3*layer))
  @relativeToAbsoluteY: (y,layer) -> y - (lastScrollY/(3*layer))

  star: (x,y) ->
    (new Molecular.Canvas.Ellipse x, StarView.relativeToAbsoluteY(y,@model.get('layer')),
      radius: 1
      line_width: 0
      blur: 3 * @model.get('layer')
      stroke_style: 'white'
      fill_style: if @model.get('layer') == 1 then 'white' else 'lightgrey'
      shadow_color: 'white'
      glowing: true
    ).inscribe()

  render: ->
    @star(@model.get('x'), @model.get('y'))




