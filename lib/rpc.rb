# largely derived from this gist: https://gist.github.com/tmm1/96699

require 'rubygems'
require 'eventmachine'
require 'socket'

module RPC
  module AbstractServer
    attr_reader :obj
    include EM::P::ObjectProtocol
    def receive_object method
      send_object @obj.__send__(*method)
    end
    def unbind
      @obj = nil
    end
  end

  class Client < BlankSlate
    def initialize sock = '/tmp/rpc.sock'
      @sock = UNIXSocket.open(sock)
    end
    def method_missing *meth
      data = Marshal.dump(meth)
      @sock.send([data.respond_to?(:bytesize) ? data.bytesize : data.size, data].pack('Na*'), 0)
      Marshal.load @sock.recv(*@sock.recv(4).unpack('N'))
    end
  end

  module RequestHandler
    module Handler
      include EM::P::ObjectProtocol
      def post_init
        @queue = []
      end
      attr_reader :queue
      def receive_object obj
        if cb = @queue.shift
          cb.call(obj)
        end
      end
    end
  end

  class AsyncClient < BlankSlate
    def initialize sock = '/tmp/rpc.sock'
      @sock = EM.connect sock, RequestHandler
    end
    def method_missing *meth, &blk
      @sock.queue << blk
      @sock.send_object(meth)
    end
  end
end

#module RPCServer
#  include EM::P::ObjectProtocol
#  def post_init
#    @obj = Hash.new
#  end
#  def receive_object method
#    send_object @obj.__send__(*method)
#  end
#  def unbind
#    @obj = nil
#  end
#end
#
#unless defined?(BlankSlate)
#  if defined?(BasicObject)
#    BlankSlate = BasicObject
#  else
#    class BlankSlate
#      instance_methods.each { |m| undef_method m unless m =~ /^__/ }
#    end
#  end
##end
#
#class RPCClient < BlankSlate
#  def initialize sock = '/tmp/rpc.sock'
#    @sock = UNIXSocket.open(sock)
#  end
#  def method_missing *meth
#    data = Marshal.dump(meth)
#    @sock.send([data.respond_to?(:bytesize) ? data.bytesize : data.size, data].pack('Na*'), 0)
#    Marshal.load @sock.recv(*@sock.recv(4).unpack('N'))
#  end
#end
#
#class AsyncRPCClient < BlankSlate
#  module Handler
#    include EM::P::ObjectProtocol
#    def post_init
#      @queue = []
#    end
#    attr_reader :queue
#    def receive_object obj
#      if cb = @queue.shift
#        cb.call(obj)
#      end
#    end
#  end
#  def initialize sock = '/tmp/rpc.sock'
#    @sock = EM.connect sock, Handler
#  end
#  def method_missing *meth, &blk
#    @sock.queue << blk
#    @sock.send_object(meth)
#  end
#end
#
## so:
##
##EM.run{
##  FileUtils.rm '/tmp/rpc.sock' if File.exists? '/tmp/rpc.sock'
##  EM.start_server '/tmp/rpc.sock', RPCServer
##
##  # use a thread because the client is blocking
##  #Thread.new{
##  #  o = RPCClient.new
##  #  o[1] = :a
##  #  o[2] = :b
##  #  o[3] = :c
##  #  p o.keys
##  #  p o.values
##  #}
##  #
##  #o = AsyncRPCClient.new
##  #o[:A] = 99
##  #o[:B] = 98
##  #o[:C] = 97
##  #o.keys{ |keys| p(keys) }
##  #o.values{ |vals| p(vals) }
#}
