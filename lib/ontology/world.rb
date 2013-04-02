class Ontology::Game::World # < Ontology::Core::Simulation
  attr_reader :state

  class << self
    def current
      @current ||= Ontology::Game::World.new
    end
  end

  def initialize(callback=nil)
    @aqmp_node = RJR::AQMPNode.new :node_id => 'worlds-core', :broker => 'localhost'
    puts puts amqp_node.invoke_request('hello', 'worldscore!')

    @state = OpenStruct.new
    @state.value = 0

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
    puts "--- step!"
    puts "=== state: #@state"
    @state.value += 1
    #fire!(:step)
    @aqmp_node.invoke_request('msg',"update: #@state")
  end

  def to_s
    #"{'value': #{@state.value}"
    {value: @state.value}.to_json.to_s
  end
end
