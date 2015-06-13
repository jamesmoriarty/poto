require "aws-sdk"
require "poto/file_repository/s3_repository/files_mapper"

module Poto
  class FileRepository
    class S3Repository
      attr_writer :page, :per_page, :query
      attr_reader :bucket

      def initialize(bucket)
        @bucket = bucket
      end

      def page(page)
        tap do |proxy|
          proxy.page = page
        end
      end

      def per_page(per_page)
        tap do |proxy|
          proxy.per_page = per_page
        end
      end

      def query(query)
        tap do |proxy|
          proxy.query = query
        end
      end

      def call
        response = Aws::S3::Client.new.list_objects(
          bucket:   bucket,
          marker:   @page,
          max_keys: @per_page,
          prefix:   @query,
        )

        FilesMapper.new(response, bucket)
      end
    end
  end
end
