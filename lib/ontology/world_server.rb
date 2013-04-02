module Ontology::WorldServer
  include RPC::AbstractServer
  def post_init
    # on local socket connection, expose the current world via RPC
    @obj = Ontology::World.current
  end
end
