require "sinatra"
require "tempfile"
require "open-uri"
require "mini_magick"

module Poto
  class ImageProxy < Sinatra::Base
    set :public_folder, File.join(File.dirname(__FILE__), "..", "..", "public")

    helpers do
      def params
        request.env['rack.request.query_hash']
      end

      def src
        CGI.unescape(params["src"])
      end

      def width
        params.fetch("width", nil).to_i
      end

      def height
        params.fetch("height", nil).to_i
      end
    end

    get("/") do
      # download src

      file = Tempfile.new('proxy')
      open(src, "rb") do |src|
        file.write(src.read)
      end
      file.close

      # resize src

      image = MiniMagick::Image.open(file.path)
      image.resize [width, height].compact.join(?x)
      image.format "png"
      image.write file.path

      # stream

      send_file file.path
    end
  end
end
