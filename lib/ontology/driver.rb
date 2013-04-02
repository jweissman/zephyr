class Ontology::Driver

  class << self
    attr_accessor :interrupted

    def trap_interrupts!
      @interrupted = false
      trap("INT") { @interrupted = true }
    end

    def core_process!
      EM.run{
        puts "*********************** ontology server running ***********************"

        FileUtils.rm '/tmp/world.sock' if File.exists? '/tmp/world.sock'
        EM.start_server '/tmp/world.sock', Ontology::WorldServer

        EM.add_periodic_timer(1) {
          Ontology::Game::World.current.step!
          if @interrupted
            puts "--- bye!"
            exit
          end
        }
      }
    end

    def launch!
      puts "This is the master worlds process."
      trap_interrupts!
      core_process!
    end
  end
end


# fire up...!
Ontology::Driver.launch!
