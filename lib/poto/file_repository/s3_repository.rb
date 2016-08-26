require "poto/file_repository/s3_repository/client"
require "poto/file_repository/s3_repository/file_collection_mapper"

module Poto
  module FileRepository
    class S3Repository
      attr_reader :bucket, :client

      def initialize(bucket:, client: Client.new(bucket))
        @bucket = bucket
        @client = client
      end

      def url(key)
        client.url(key)
      end

      def all(prefix:, page:, per_page:)
        objects = client.objects(
          page:     page,
          per_page: per_page,
          prefix:   prefix,
        )

        FileCollectionMapper.new(objects)
      end
    end
  end
end
