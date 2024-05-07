class Client
  require 'socket'

  def initialize(hostname, port)
    @hostname = hostname
    @port = port
  end

  def connect
    @server = TCPSocket.open(@hostname, @port)
  end

  def ping
    @server.puts 'ping'
    puts @server.gets.chomp
  end

  def close
    @server.close
  end
end

client = Client.new('localhost', 5678)
client.connect
client.ping
client.close
