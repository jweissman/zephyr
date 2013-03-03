class Game extends atom.Game
  constructor: ->
    super
    atom.input.bind atom.button.LEFT, 'click'
    atom.input.bind atom.button.RIGHT, 'rightclick'

  update: (dt) ->
    if atom.input.released 'click'
      StarsView.click(atom.input.mouse)

  draw: ->
    StarsView.render()

game = new Game

window.onblur  = -> game.stop()
window.onfocus = -> game.run()

game.run()
