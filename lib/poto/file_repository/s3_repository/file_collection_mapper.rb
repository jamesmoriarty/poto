require "poto/file_repository/s3_repository/file_mapper"

module Poto
  module FileRepository
    class S3Repository
      class FileCollectionMapper
        attr_reader :objects, :bucket, :client

        def initialize(objects, bucket:, client:)
          @objects = objects
          @bucket  = bucket
          @client  = client
        end

        def files
          objects.contents.map do |object|
            FileMapper.new(object, bucket: bucket, client: client)
          end
        end

        def page
          objects.marker
        end

        def next_page
          files.last.try(:name)
        end
      end
    end
  end
end
