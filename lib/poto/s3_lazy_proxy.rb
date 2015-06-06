require "aws-sdk"

module Poto
  class FileRepository
    class S3LazyProxy
      attr_writer :page, :per_page, :query

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

        files = response.contents.map do |struct|
          File.new(struct.key, struct.size, url(struct.key))
        end

        Files.new(files, response.marker, files.last.name)
      end

      def url(key)
        Aws::S3::Object.new(bucket, key).presigned_url(:get, expires_in: 3600)
      end

      def bucket
        ENV["AWS_S3_BUCKET"]
      end
    end
  end
end
