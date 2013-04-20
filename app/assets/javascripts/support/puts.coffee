root = (exports ? this)

# too much? i might start getting the syntaxes (even more) mixed up...!
root.puts = (msg) ->
  console.log msg
  console.warn "stray puts!"

# the idea is to catch potential issues maybe?
