require "digest"

module Poto
  class FileCache
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def cache(key, &set)
      File.join(path, cache_file(key)).tap do |cache_path|
        unless File.exists?(cache_path)
          FileUtils.cp(set.call, cache_path)
        end
      end
    end

    private

    def cache_file(key)
      Digest::SHA256.hexdigest(key)
    end
  end
end
