require "open-uri"
require "poto/ext/open_uri"

module Poto
  module Services
    class Download
      attr_reader :file, :uri

      def initialize(file:, uri:)
        @file, @uri = file, uri
      end

      def call
        open(uri) do |src|
          file.write(src.read)
        end

        file.close
        file.path
      end
    end
  end
end
