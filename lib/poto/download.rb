module Poto
  class Download
    attr_reader :file, :uri

    def initialize(file:, uri:)
      @file, @uri = file, uri
    end

    def call
      open(uri, "rb") do |src|
        file.write(src.read)
      end

      file.close
      file.path
    end
  end
end
