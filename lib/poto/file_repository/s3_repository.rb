require "aws-sdk"
require "poto/file_repository/s3_repository/s3_client"
require "poto/file_repository/s3_repository/file_collection_mapper"

module Poto
  module FileRepository
    class S3Repository
      attr_reader :bucket, :client

      def initialize(bucket:, client: S3Client.new(bucket))
        @bucket = bucket
        @client = client
      end

      def call(prefix:, page:, per_page:)
        objects = client.list_objects(
          bucket:   bucket,
          marker:   page,
          max_keys: per_page,
          prefix:   prefix,
        )

        FileCollectionMapper.new(objects, bucket: bucket, client: client)
      end
    end
  end
end
