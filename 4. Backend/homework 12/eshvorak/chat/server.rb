require 'socket'

class Server
  def initialize(port)
    @port = port
    @server = TCPServer.new(port)
    @clients = []
    @running = true
  end

  def run
    puts "Server is running on port #{@port}"
    while @running
      Thread.start(@server.accept) do |client|
        @clients << client
        listen_messages(client)
      end
    end
  rescue StandardError => e
    puts e.message
  ensure
    @server.close if @server
  end

  def stop
    @running = false
    @clients.each { |client| client.close }
    @server.close
  end

  private

  def listen_messages(client)
    Thread.start do
      while message = client.gets
        broadcast_message(message, client)
      end
    end
  end

  def broadcast_message(message, sender)
    @clients.each do |client|
      client.puts message unless client == sender
    end
  end
end


server = Server.new(1234)
server.run