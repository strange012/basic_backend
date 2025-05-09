require 'socket'

class Client
  attr_reader :running

  def initialize(hostname, port)
    @server = TCPSocket.open(hostname, port)
    puts "Connected to the server..."
    @running = true
    Thread.new { send_messages }
    receive_messages
  end

  def send_messages
    while @running
      message = gets.chomp
      begin
        @server.puts message unless message.nil?
      rescue => e
        puts "Error sending message: #{e.message}"
        stop
      end
    end
  end

  def receive_messages
    while @running
      message = @server.gets
      if message.nil?
        puts "Connection closed by server."
        stop
      else
        puts message.chomp
      end
    end
  end

  def stop
    @running = false
    @server.close
  rescue
    # already closed
  end
end

client = Client.new('localhost', 1234)

loop do
  break unless client.running
  sleep 1
end
