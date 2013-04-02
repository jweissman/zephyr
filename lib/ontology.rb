#module Ontology; end
#
#require "ontology/driver"
#require "ontology/world"
#require "ontology/world_server"
#require "ontology/zeronaut"

# launch worlds server...
#Ontology::Driver.launch!


## world server
# pure ruby (?) -- to be kicked off by rails runner presumably...
## keeping here just to keep my head in the same space, but should probably be run on a separate machine
#
#module Ontology
#  class Actor
#    def step!
#      puts "--- would be stepping actor... [no-op in superclass]"
#    end
#  end
#
#  class World
#    attr_accessor :actors
#    def evolve!
#      puts "--- would be evolving world... [no-op in superclass]"
#      @actors.each &:step!
#    end
#    #class << self
#    #  def actor
#    #    new_actor = Actor.new
#    #    yield new_actor
#    #    @actors << new_actor
#    #  end
#    #end
#  end
#
#  class WorldRunner < Struct.new(:world)
#    def run!
#      world.evolve! while true
#    end
#  end
#end
#
####
#
#include Ontology
#WorldRunner.new(World.new).run!
