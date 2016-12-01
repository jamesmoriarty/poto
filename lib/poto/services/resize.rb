require 'mini_magick'

module Poto
  module Services
    class Resize
      attr_reader :path, :width, :height

      def initialize(path:, width:, height:)
        @path = path
        @width = width
        @height = height
      end

      def call
        image = MiniMagick::Image.open(path)
        image.resize([width, height].compact.join('x'))
        image.format('png')
        image.write(path)
        image.path
      end
    end
  end
end
