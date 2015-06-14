require "sinatra"
require "tempfile"
require "open-uri"
require "mini_magick"

module Poto
  class ImageProxy < Sinatra::Base
    set :public_folder, File.join(File.dirname(__FILE__), "..", "..", "public")

    helpers do
      def src
        params["src"]
      end

      def width
        params["width"].to_i
      end

      def height
        params["height"].to_i
      end

      def download(url)
        Tempfile.new('proxy').tap do |file|
          open(url, "rb") do |src|
            file.write(src.read)
          end

          file.close
        end.path
      end

      def resize(path, height, width)
        image = MiniMagick::Image.open(path)
        image.resize([width, height].compact.join(?x))
        image.format("png")
        image.write(path)
      end

      def file_cache(url, &block)
        path       = URI(url).path
        dir        = File.dirname(path)
        cache_path = File.join(settings.public_dir, "cache", URI.unescape(path))

        unless File.exists?(cache_path)
          FileUtils.mkdir_p(File.join(settings.public_dir, "cache", dir))
          FileUtils.mv(yield, cache_path)
        end

        File.join("cache", path)
      end
    end

    get("/") do
      redirect to(
        file_cache(src) do
          download(src).tap do |path|
            resize(path, height, width)
          end
        end
      )
    end
  end
end
