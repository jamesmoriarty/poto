require "bundler/setup"
require "rack/hal_browser"
require "poto"

map("/") do
  use Rack::HalBrowser::Redirect
  run Poto::App
end

map("/api") do
  run Poto::API
end
