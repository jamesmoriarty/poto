require "aws-sdk"

module Poto
  module FileRepository
    class S3Repository
      class FileMapper
        attr_reader :object, :bucket, :client

        def initialize(object, bucket:, client:)
          @object = object
          @bucket = bucket
          @client = client
        end

        def name
          object.key
        end

        def size
          object.size
        end
      end
    end
  end
end
