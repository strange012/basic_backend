class Server
  require 'socket'
  
  def initialize(port)
    @server = TCPServer.new(port)
  end

  def start
    loop do
      session = @server.accept
      handle_session(session)
    end
  end

  private

  def handle_session(session)
    request = session.gets.chomp
    case request
    when 'ping'
      session.puts 'pong'
    else
      session.puts "Hello world! The time is #{Time.now}"
    end
    session.close
  end
end

server = Server.new(5678)
server.start
