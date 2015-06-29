require "poto/file_repository/s3_repository"

module Poto
  class FileRepository
    class Proxy
      attr_writer :page, :per_page, :query

      def initialize(repo)
        @repo = repo
      end

      def call
        @repo.call(query: @query, page: @page, per_page: @per_page)
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
    end

    class << self
      def proxy
        Proxy.new(S3Repository.new(bucket: ENV["AWS_S3_BUCKET"]))
      end

      delegate :page, :per_page, :query, to: :proxy
    end
  end
end
