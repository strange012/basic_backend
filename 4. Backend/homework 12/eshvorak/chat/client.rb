require 'socket'

class Client
  attr_reader :running

  def initialize(hostname, port)
    @server = TCPSocket.open(hostname, port)
    puts "Connected to the server..."
    @running = true
    send_messages
    receive_messages
  end

  def send_messages
    Thread.new do
      while @running
        message = gets.chomp
        @server.puts message unless message.nil?
      end
    end
  end

  def receive_messages
    Thread.new do
      while @running
        message = @server.gets
        puts message.chomp unless message.nil?
      end
    end
  end

  def stop
    @running = false
    @server.close
  end
end

client = Client.new('localhost', 1234)

loop do
  break unless client.running
  sleep 1
end
