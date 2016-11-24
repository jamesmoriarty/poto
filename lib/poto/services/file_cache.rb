require "digest"

module Poto
  module Services
    class FileCache
      attr_reader :path

      def initialize(path:)
        @path = path
      end

      def cache(key, &set)
        File.join(path, filename(key)).tap do |file_path|
          unless File.exists?(file_path)
            FileUtils.cp(set.call, file_path)
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
