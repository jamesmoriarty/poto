require "bundler/setup"
require "poto"

map("/") do
  run Poto::App
end

map("/proxy") do
  run Poto::Proxy
end

map("/api") do
  run Poto::API
end
