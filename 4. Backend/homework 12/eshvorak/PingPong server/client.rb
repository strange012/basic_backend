require 'socket'

class Client
  
  def initialize(hostname, port)
    @hostname = hostname
    @port = port
    @server = TCPSocket.open(@hostname, @port)
  end

  def ping
    push('ping')
  end

  def push(message)
    @server.puts message
    puts @server.gets.chomp
  end

  def close
    @server.close
  end

  class << self
    def start(host, port, &block)
      client = new(host, port)
      block.call(client)
      client.close
    end
  end
end

client = Client.new('localhost', 5678)
client.ping
  