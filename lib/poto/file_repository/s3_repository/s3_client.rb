module Poto
  module FileRepository
    class S3Repository
      class S3Client
        attr_reader :bucket

        def initialize(bucket)
          @bucket = bucket
        end

        def list_objects(prefix:, page:, per_page:)
          Aws::S3::Client.new.list_objects(
            bucket:   bucket,
            marker:   page,
            max_keys: per_page,
            prefix:   prefix,
          )
        end

        def presigned_url(object)
          Aws::S3::Object.new(bucket, object.key).presigned_url(:get, expires_in: 3600)
        end
      end
    end
  end
end
