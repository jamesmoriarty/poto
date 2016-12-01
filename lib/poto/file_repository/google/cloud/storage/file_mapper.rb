require 'base64'

require 'poto/file_repository/file'

module Poto
  module FileRepository
    module Google
      module Cloud
        class Storage
          class FileMapper
            attr_reader :file

            def initialize(file)
              @file = file
            end

            def call
              File.new(id, name, size)
            end

            private

            def name
              file.name
            end

            def size
              file.size
            end

            def id
              file.name
            end
          end
        end
      end
    end
  end
end
