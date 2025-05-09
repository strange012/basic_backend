require 'socket'
require 'time'

class Server
  def initialize(port)
    @port = port
    @server = TCPServer.new(port)
    @clients = {}
    @message_history = []
    @running = true
  end

  def run
    puts "Server is running on port #{@port}"
    Thread.new { admin_input }

    while @running
      client = @server.accept
      Thread.new { handle_client(client) }
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
  ensure
    stop
  end

  def stop
    @running = false
    @clients.each { |_, client| client.close }
    @server.close if @server
  end

  private

  def handle_client(client)
    client.puts "Enter your name:"
    name = client.gets.chomp

    @clients[client] = name
    send_message_history(client)
    broadcast_message("#{name} has joined the chat", client)

    listen_for_messages(client)
  rescue StandardError => e
    puts "Error handling client: #{e.message}"
  ensure
    disconnect_client(client)
  end

  def send_message_history(client)
    @message_history.each do |message|
      client.puts message
    end
  end

  def listen_for_messages(client)
    while (message = client.gets)
      broadcast_message(message.chomp, client)
    end
  end

  def broadcast_message(message, sender)
    time = Time.now.strftime("%Y-%m-%d %H:%M")
    sender_name = @clients[sender]
    formatted_message = sender_name ? "[#{time}] #{sender_name}: #{message}" : "[#{time}] #{message}"

    puts formatted_message
    @message_history << formatted_message

    @clients.each do |client, _|
      next if client == sender

      begin
        client.puts formatted_message
      rescue => e
        puts "Error sending message to client: #{e.message}"
      end
    end
  end

  def disconnect_client(client)
    name = @clients.delete(client)
    if name
      broadcast_message("#{name} has left the chat", client)
    end
    client.close
  rescue => e
    puts "Error disconnecting client: #{e.message}"
  end

  def admin_input
    while @running
      message = gets.chomp
      broadcast_message("ADMIN: #{message}", nil)
    end
  end
end

server = Server.new(1234)
server.run
