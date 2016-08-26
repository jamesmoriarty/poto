require "aws-sdk"

module Poto
  module FileRepository
    class S3Repository
      class Client
        attr_reader :bucket

        def initialize(bucket)
          @bucket = bucket
        end

        def objects(query:, page:, per_page:)
          Aws::S3::Client.new.list_objects(
            bucket:   bucket,
            marker:   page,
            max_keys: per_page,
            prefix:   query,
          )
        end

        def url(key)
          Aws::S3::Object.new(bucket, key).presigned_url(:get, expires_in: 3600)
        end
      end
    end
  end
end
