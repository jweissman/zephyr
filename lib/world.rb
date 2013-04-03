require 'blank_slate'
require 'rpc'

Rails.logger = Logger.new(STDOUT) # for sanity's sake at least while debugging
#Rails.logger.auto_flushing = true
#Rails.logger.info "HELLO WORLD"
#puts "HL#RLHELLOOOO"

class World # < Ontology::Core::Simulation
  attr_reader :state

  class << self
    def current
      @current ||= World.new
    end
  end

  def initialize
    #@aqmp_node = RJR::AQMPNode.new :node_id => 'worlds-core', :broker => 'localhost'
    #puts puts amqp_node.invoke_request('hello', 'worldscore!')

    @state = OpenStruct.new
    @state.value = 0

    @state.players  = []
    # @state.map      = new Map()
    # ...

    #@event_callback = callback
    # a new world is by default the 'current' world
    # (single threaded, single world model for now...)
    #Ontology::Game::World.current = self
  end

  #def each_event(&blk)
  #  @event_callback = blk
  #end

  #def fire!(evt)
  #  @event_callback.call(evt)
  #end

  def step!
    Rails.logger.info "--- step!"
    Rails.logger.info "=== state: #@state"
    @state.value += 1
    #fire!(:step)

    # for evt callbacks, maybe something like:
    #  @aqmp_node.invoke_request('msg',"update: #@state")
  end

  #def to_s
  #  #"{'value': #{@state.value}"
  #  {value: @state.value}.to_json
  #end
end

module WorldServer
  include ::RPC::AbstractServer
  def post_init
    # on local socket connection, expose the current world via RPC
    @obj = World.current
  end
end

# wrapper around process/DRB helper
class WorldDriver

  class << self
    attr_accessor :interrupted

    def trap_interrupts!
      @interrupted = false
      trap("INT") { @interrupted = true }
    end

    def core_process!
      EM.run{
        Rails.logger.info "*********************** ontology server running ***********************"


        FileUtils.rm '/tmp/world.sock' if File.exists? '/tmp/world.sock'
        EM.start_server '/tmp/world.sock', WorldServer

        EM.add_periodic_timer(1) {
          World.current.step!
          if @interrupted
            Rails.logger.debug "--- bye!"
            exit
          end
        }
      }
    end

    def launch!
      trap_interrupts!
      core_process!
    end
  end
end
