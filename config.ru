require "bundler/setup"
require "poto"

map("/") do
  run Poto::App
end

map("/image_proxy") do
  run Poto::ImageProxy
end

map("/api") do
  run Poto::API
end
