require "digest"

module Poto
  class FileCache
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def cache(key, &set)
      File.join(path, Digest::SHA256.hexdigest(key)).tap do |cache_path|
        unless File.exists?(cache_path)
          FileUtils.mv(set.call, cache_path)
        end
      end
    end
  end
end
