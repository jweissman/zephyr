class Game extends atom.Game
  constructor: ->
    super
    atom.input.bind atom.button.LEFT, 'click'
    atom.input.bind atom.button.RIGHT, 'rightclick'

  update: (dt) ->
    if atom.input.released 'click'
      StarsView.click(atom.input.mouse)

    Stars.update()

  draw: ->
    StarsView.render()

game = new Game

# hard to validate sync with this on :)
#window.onblur  = -> game.stop()
#window.onfocus = -> game.run()

game.run()
