require 'digest'

module Poto
  module Services
    class FileCache
      attr_reader :path

      def initialize(path:)
        @path = path
      end

      def cache(key)
        File.join(path, filename(key)).tap do |cache_path|
          unless File.exist?(cache_path)
            file_path = yield
            FileUtils.cp(file_path, cache_path)
          end
        end
      end

      private

      def filename(key)
        Digest::SHA256.hexdigest(key)
      end
    end
  end
end
