$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require "bundler/setup"
require "poto"
require "poto/file_repository/s3"

repository = Poto::FileRepository::S3.new(bucket: ENV["AWS_S3_BUCKET"])

map("/") do
  run Poto::App
end

map("/image_proxy") do
  run Poto::ImageProxy
end

map("/api") do
  run Poto::API.configure(repository: repository)
end
