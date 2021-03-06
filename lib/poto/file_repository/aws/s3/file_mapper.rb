require 'base64'

require 'poto/file_repository/file'

module Poto
  module FileRepository
    module AWS
      class S3
        class FileMapper
          attr_reader :object

          def initialize(object)
            @object = object
          end

          def call
            File.new(id, name, size)
          end

          private

          def name
            object.key
          end

          def size
            object.size
          end

          def id
            object.key
          end
        end
      end
    end
  end
end
