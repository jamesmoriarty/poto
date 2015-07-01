require 'webrick'

def http_server(port, root_path, &block)
  server = WEBrick::HTTPServer.new(Port: port,)
  server.mount("/", WEBrick::HTTPServlet::FileHandler, root_path)
  thread = Thread.new { server.start }
  block.call(server)
  server.stop
  thread.join
end
