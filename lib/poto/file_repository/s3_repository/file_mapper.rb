require "aws-sdk"

module Poto
  class FileRepository
    class S3Repository
      class FileMapper
        attr_reader :object, :bucket

        def initialize(object, bucket)
          @object = object
          @bucket = bucket
        end

        def name
          object.key
        end

        def size
          object.size
        end

        def file_url
          Aws::S3::Object.new(bucket, object.key).presigned_url(:get, expires_in: 3600)
        end
      end
    end
  end
end
