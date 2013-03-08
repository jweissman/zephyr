class Zephyr.Views.StarView extends Backbone.View
  radius: 1.5
  initialize: ->
  star: (x,y) -> new Molecular.Canvas.Ellipse x,y, {
    radius: @radius
    line_width: 0
    blur: 8
    stroke_style: 'grey'
    fill_style: 'white'
    shadow_color: 'white'
    glowing: true
  }

  render: ->
    @star(@model.get('x'), @model.get('y')).inscribe()
