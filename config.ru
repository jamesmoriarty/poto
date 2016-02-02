require "bundler/setup"
require "poto"

backend = FileRepository::S3Repository.new(bucket: ENV["AWS_S3_BUCKET"])

map("/") do
  run Poto::App
end

map("/image_proxy") do
  run Poto::ImageProxy
end

map("/api") do
  run Poto::API.new(backend)
end
