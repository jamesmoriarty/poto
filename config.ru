require "bundler/setup"
require "poto"

map("/") do
  run Poto::App
end

map("/api") do
  run Poto::API
end
