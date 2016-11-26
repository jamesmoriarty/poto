$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require "bundler/setup"
require "poto"
# require "poto/file_repository/aws/s3"
#
# repository = Poto::FileRepository::AWS::S3.new(bucket: ENV["AWS_S3_BUCKET"])

require "poto/file_repository/google/cloud/storage"

bucket = Google::Cloud::Storage.new(
  project: "poto-1266",
  keyfile: "Poto-f69886a81372.json"
).bucket("poto")

repository = Poto::FileRepository::Google::Cloud::Storage.new(bucket: bucket)

map("/") do
  run Poto::App
end

map("/image_proxy") do
  run Poto::ImageProxy
end

map("/api") do
  run Poto::API.configure(repository: repository)
end
