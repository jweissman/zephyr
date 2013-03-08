## has really been superseded by the various app views now
# TODO reinstate this -- having a global app view makes a lot of sense
class Zephyr.Views.ApplicationView extends Backbone.View
  initialize: ->
    @launching = false; @launched = false

  launch: ->
    @launching = true
    @engine = new Molecular.Engine @
    @engine.run()
    @launching = false
    @launched = true

  render: ->
    if @launched
      @view.draw()

  click: (mouse) ->
    if @launched
      @view.click(mouse)
