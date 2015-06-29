require "aws-sdk"
require "poto/file_repository/s3_repository/files_mapper"

module Poto
  class FileRepository
    class S3Repository
      attr_reader :bucket

      def initialize(bucket:)
        @bucket = bucket
      end

      def call(query:, page:, per_page:)
        response = Aws::S3::Client.new.list_objects(
          bucket:   bucket,
          marker:   page,
          max_keys: per_page,
          prefix:   query,
        )

        FilesMapper.new(response, bucket)
      end
    end
  end
end
