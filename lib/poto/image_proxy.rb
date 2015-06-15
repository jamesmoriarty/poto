require "sinatra"
require "tempfile"
require "tmpdir"
require "open-uri"
require "mini_magick"
require "digest"

module Poto
  class ImageProxy < Sinatra::Base
    set :public_folder, File.join(File.dirname(__FILE__), "..", "..", "public")

    helpers do
      def src
        URI(params["src"])
      end

      def width
        params["width"].to_i
      end

      def height
        params["height"].to_i
      end

      def download(uri)
        Tempfile.new(self.class.name).tap do |dst|
          open(uri, "rb") do |src|
            dst.write(src.read)
          end

          dst.close
        end.path
      end

      def resize(path, height, width)
        MiniMagick::Image.open(path).tap do |image|
          image.resize([width, height].compact.join(?x))
          image.format("png")
          image.write(path)
        end.path
      end

      def cache(key, &set)
        File.join(Dir.tmpdir, Digest::SHA256.hexdigest(key)).tap do |cache_path|
          unless File.exists?(cache_path)
            FileUtils.mv(set.call, cache_path)
          end
        end
      end
    end

    get("/") do
      src_path = cache(src.path) { download(src) }
      dst_path = cache("#{src_path}#{width}x#{height}") { resize(src_path, height, width) }

      etag Digest::SHA256.hexdigest(dst_path), kind: :weak
      send_file dst_path
    end
  end
end
