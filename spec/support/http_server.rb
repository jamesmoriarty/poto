require 'webrick'

def http_server(port, root_path)
  server = WEBrick::HTTPServer.new(Port: port)
  server.mount('/', WEBrick::HTTPServlet::FileHandler, root_path)
  thread = Thread.new { server.start }
  yield(server)
  server.shutdown
  thread.exit
end
