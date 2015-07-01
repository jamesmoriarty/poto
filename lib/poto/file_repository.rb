require "poto/file_repository/s3_repository"

module Poto
  class FileRepository
    class Proxy
      attr_writer :page, :per_page, :prefix

      def initialize(repo)
        @repo = repo
      end

      def call
        @repo.call(prefix: @prefix, page: @page, per_page: @per_page)
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

      def prefix(prefix)
        tap do |proxy|
          proxy.prefix = prefix
        end
      end
    end

    class << self
      def proxy
        Proxy.new(S3Repository.new(bucket: ENV["AWS_S3_BUCKET"]))
      end

      delegate :page, :per_page, :prefix, to: :proxy
    end
  end
end
