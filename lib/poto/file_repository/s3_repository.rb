require "aws-sdk"
require "poto/file_repository/s3_repository/file_collection_mapper"

module Poto
  class FileRepository
    class S3Repository
      attr_reader :bucket

      def initialize(bucket:)
        @bucket = bucket
      end

      def call(prefix:, page:, per_page:)
        response = client.list_objects(
          bucket:   bucket,
          marker:   page,
          max_keys: per_page,
          prefix:   prefix,
        )

        FileCollectionMapper.new(response, bucket)
      end

      private

      def client
        Aws::S3::Client.new
      end
    end
  end
end
