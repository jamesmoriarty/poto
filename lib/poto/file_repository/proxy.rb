module Poto
  module FileRepository
    class Proxy
      attr_reader :backend

      def initialize(backend)
        @backend = backend
      end

      def url(id)
        backend.url(id)
      end

      def all
        backend.all(prefix: @prefix, page: @page, per_page: @per_page)
      end

      def page(page)
        tap do |proxy|
          @page = page
        end
      end

      def per_page(per_page)
        tap do |proxy|
          @per_page = per_page
        end
      end

      def prefix(prefix)
        tap do |proxy|
          @prefix = prefix
        end
      end
    end
  end
end
