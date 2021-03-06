require 'base64'
require 'poto/file_repository/aws/s3/client'
require 'poto/file_repository/aws/s3/file_collection_mapper'

module Poto
  module FileRepository
    module AWS
      class S3
        attr_reader :bucket, :client

        def initialize(bucket:, client: Client.new(bucket))
          @bucket = bucket
          @client = client
        end

        def url(id)
          client.url(id)
        end

        def all(prefix:, page:, per_page:)
          objects = client.objects(
            page:     page,
            per_page: per_page,
            prefix:   prefix
          )

          FileCollectionMapper.new(objects).call
        end
      end
    end
  end
end
