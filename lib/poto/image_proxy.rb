require "sinatra"
require "tempfile"
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

      def download(url)
        Tempfile.new(self.class.name).tap do |file|
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
    end

    get("/") do
      etag Digest::SHA256.hexdigest("#{src.path}#{width}#{height}"), kind: :weak

      path = download(src)
      resize(path, height, width)
      send_file path
    end
  end
end
