require "digest"

module Poto
  module Services
    class FileCache
      attr_reader :path

      def initialize(path:)
        @path = path
      end

      def cache(key, &set)
        File.join(path, filename(key)).tap do |cache_path|
          if !File.exists?(cache_path)
            file_path = set.call
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
