# game server
# written in rjr
# probably kicked off by rails runner?

RJR::Dispatcher.add_handler("hello") { |arg|
  puts "=== HELLO"
  arg.upcase
}

RJR::Dispatcher.add_handler("msg") { |arg| #channel,nick,msg|
  puts "=== MSG"
  arg.upcase
                                           # distribute messages to every client...?
                                           #Channels.get(channel).message(nick,msg)
}

RJR::Dispatcher.add_handler("world") { |*args|
  puts "=== WORLD"
  args.join(', ')
  # could actually route through em::object::p to the underlying world object (!)
  # (and then on the JS side wrap key methods...)
}

aqmp_node   = RJR::AMQPNode.new :node_id => 'worlds-server', :broker => 'localhost'
ws_node     = RJR::WSNode.new   :node_id => 'worlds-server', :host => 'localhost', :port => 9000
ws_node.listen
ws_node.join
