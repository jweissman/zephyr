root = exports ? this

class Mixin
  augment: (t) ->
    (t[n] = m unless n == 'augment' or !this[n].prototype?) for n, m of this
    t.setup()
  eject: (mixin) ->
    (delete this[n] if m in (p for o, p of mixin::)) for n, m of this
  setup: ->

root.Mixin = Mixin
