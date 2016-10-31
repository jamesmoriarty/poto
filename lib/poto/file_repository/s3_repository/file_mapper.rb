module Poto
  module FileRepository
    class S3Repository
      class FileMapper
        attr_reader :object

        def initialize(object)
          @object = object
        end

        def name
          object.key
        end

        def size
          object.size
        end

        def id
          encode object.key
        end

        private

        def encode(value)
          URI.escape Base64.encode64 name
        end
      end
    end
  end
end
