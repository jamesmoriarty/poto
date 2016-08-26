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
      end
    end
  end
end
