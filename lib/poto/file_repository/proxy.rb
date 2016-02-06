module Poto
  module FileRepository
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
  end
end
