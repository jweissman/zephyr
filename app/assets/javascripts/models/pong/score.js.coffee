class Zephyr.Models.Score extends Backbone.Model
  defaults:
    human: 0
    cpu: 0

  incrementHuman: -> @set('human', @get('human')+1)
  incrementCpu: -> @set('cpu', @get('cpu')+1)
  formatScore: -> "#{@get('human')} | #{@get('cpu')}"
