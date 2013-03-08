window.Stars       = new Zephyr.Collections.Stars()
window.StarsView   = new Zephyr.Views.StarsView {collection: Stars}
window.Star        = Zephyr.Models.Star
window.StarView    = Zephyr.Views.StarView

class Universe
  initialize: ->    Stars.fetch({})
  update: ->        Stars.update()
  draw: ->          StarsView.render()
  click: (mouse) -> StarsView.click(mouse)

window.AppView      = new Zephyr.Views.ApplicationView({view: StarsView})

