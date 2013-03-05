#postFactory = BackboneFactory.define("post", Post)

#console.log "--- loaded factories!"

#window.dice = (n) ->
#  Math.floor(Math.random() * n) + 1
#
#window.emailSequence = BackboneFactory.define_sequence "email", (n) ->
#  "person" + n + "@example.com"
#
#window.starFactory = BackboneFactory.define "star", ->
#  x: dice 4
#  y: dice 3
