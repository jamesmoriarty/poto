require 'poto/file_repository/dsl'

module Poto
  module FileRepository
    class Proxy
      include DSL

      option :per_page
      option :page
      option :prefix

      attr_reader :backend

      def initialize(backend)
        @backend = backend
      end

      def url(id)
        backend.url(id)
      end

      def all
        backend.all(options)
      end
    end
  end
end
