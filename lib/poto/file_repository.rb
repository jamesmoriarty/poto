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

    attr_reader :backend, :args

    def initialize(backend, *args)
      @backend = backend
      @args    = args
    end

    def proxy
      Proxy.new(backend.new(*args))
    end

    delegate :page, :per_page, :prefix, to: :proxy
  end
end
