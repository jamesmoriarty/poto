require "aws-sdk"
module Poto
  class FileRepository
    class S3Proxy
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

        def proxy_url
          "/proxy?" + { src: CGI.escape(file_url), width: 500, height: 500 }.to_param
        end

        def file_url
          Aws::S3::Object.new(bucket, object.key).presigned_url(:get, expires_in: 3600)
        end
      end
    end
  end
end
