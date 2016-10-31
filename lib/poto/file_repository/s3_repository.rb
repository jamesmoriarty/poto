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

      def url(id)
        client.url(decode(id))
      end

      def all(prefix:, page:, per_page:)
        objects = client.objects(
          page:     page,
          per_page: per_page,
          prefix:   prefix,
        )

        FileCollectionMapper.new(objects)
      end

      private

      def decode(value)
        URI.unescape(Base64.decode64(value))
      end
    end
  end
end
