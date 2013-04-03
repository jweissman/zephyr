# game server
# written in rjr
# probably kicked off by rails runner?
Rails.logger = Logger.new(STDOUT) # for sanity's sake at least while debugging
#Rails.logger.auto_flushing = true

#puts "HL#RLHELLOOOO"


class Zeronaut
  def self.launch!
    Rails.logger.info "==== hello!"
    RJR::Dispatcher.add_handler("hello") { |arg|
      Rails.logger.info "=== HELLO"
      arg.upcase
    }

    RJR::Dispatcher.add_handler("msg") { |arg| #channel,nick,msg|
      Rails.logger.info "=== MSG"
      arg.upcase
                                               # distribute messages to every client...?
                                               #Channels.get(channel).message(nick,msg)
    }

    RJR::Dispatcher.add_handler("world") { |*args|
      Rails.logger.info "=== WORLD"
      args.join(', ')
      # could actually route through em::object::p to the underlying world object (!)
      # (and then on the JS side wrap key methods...)
    }

    aqmp_node   = RJR::AMQPNode.new :node_id => 'worlds-server', :broker => 'localhost'
    ws_node     = RJR::WSNode.new   :node_id => 'worlds-server', :host => 'localhost', :port => 8080
    ws_node.listen
    ws_node.join

  end
end

