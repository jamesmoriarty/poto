require "sinatra"
require "tmpdir"

require "poto/services/download"
require "poto/services/file_cache"
require "poto/services/resize"

module Poto
  class ImageProxy < Sinatra::Base
    set :cache_path, Dir.tmpdir

    helpers do
      def src
        URI(params["src"].gsub(/\A\/\//, "http://"))
      end

      def width
        params["width"].to_i
      end

      def height
        params["height"].to_i
      end

      def cache(key, &set)
        Services::FileCache.new(path: settings.cache_path).cache(key, &set)
      end

      def download(uri)
        Services::Download.new(file: Tempfile.new(settings.cache_path), uri: uri).call
      end

      def resize(path, height, width)
        Services::Resize.new(path: path, height: height, width: width).call
      end
    end

    get("/") do
      src_path = cache(src.path)                        { download(src) }
      dst_path = cache("#{src_path}#{width}x#{height}") { resize(src_path, height, width) }

      send_file(dst_path)
    end
  end
end
